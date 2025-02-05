import 'package:flutter/material.dart';
import 'dart:io'; // 파일 처리를 위해 사용
import 'package:image_picker/image_picker.dart'; // 이미지 선택을 위해 사용
import 'package:http/http.dart' as http; // HTTP 요청을 위해 사용
import 'dart:convert'; // JSON 데이터 처리에 사용

class OnjungTab extends StatefulWidget {
  const OnjungTab({super.key});

  @override
  State<OnjungTab> createState() => _OnjungTabState();
}

class _OnjungTabState extends State<OnjungTab> {
  File? _selectedImage; // 선택한 이미지 파일
  List<List<String>> _tableData = []; // 최종 표 데이터 (데이터 행만)
  final ImagePicker _picker = ImagePicker(); // 이미지 선택 도구 초기화

  // 고정 헤더
  final List<String> _header = ["No.", "성명", "금액", "주소 및 기타"];

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // 선택한 이미지 저장
        _tableData = []; // 새 이미지 선택 시 표 데이터 초기화
      });
    }
  }

  // 구글 Vision API를 통해 OCR 수행
  Future<void> _performOCR() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미지를 선택해주세요.')),
      );
      return;
    }

    try {
      // 구글 Vision API 키
      final apiKey = "YOUR_GOOGLE_VISION_API_KEY";
      final url = Uri.parse(
          'https://vision.googleapis.com/v1/images:annotate?key=$apiKey');

      final imageBytes = await _selectedImage!.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      // 구글 Vision API 요청 데이터 생성
      final requestPayload = {
        "requests": [
          {
            "image": {"content": base64Image},
            "features": [
              {"type": "TEXT_DETECTION"}
            ],
            "imageContext": {
              "languageHints": ["ko", "en"] // 한국어와 영어 우선 처리
            }
          }
        ]
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestPayload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final textAnnotations = data['responses'][0]['textAnnotations'];
        if (textAnnotations != null && textAnnotations.isNotEmpty) {
          final rawText = textAnnotations[0]['description'];
          print("OCR 결과: $rawText");
          final cleanedText = _cleanOCRText(rawText);
          await _processWithGPT(cleanedText);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('텍스트를 인식하지 못했습니다.')),
          );
        }
      } else {
        throw Exception('OCR API 호출 실패: ${utf8.decode(response.bodyBytes)}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  // OCR 텍스트를 정리하는 함수
  String _cleanOCRText(String rawText) {
    final cleanedText = rawText
        .replaceAll(RegExp(r'[^\uAC00-\uD7A3a-zA-Z0-9\s.,/-]'), '') // 이상한 문자 제거
        .replaceAll(RegExp(r'\s+'), ' ') // 연속된 공백을 하나로
        .trim();
    print("정리된 OCR 결과: $cleanedText");
    return cleanedText;
  }

  // OpenAI GPT API를 통해 표 데이터를 생성
  Future<void> _processWithGPT(String rawText) async {
    try {
      final apiKey = "YOUR_OPENAI_GPT_API_KEY";
      final url = Uri.parse('https://api.openai.com/v1/chat/completions');

      final requestPayload = {
        "model": "gpt-4",
        "messages": [
          {
            "role": "system",
            "content": "다음 텍스트 데이터를 기반으로 표 데이터를 생성해주세요. "
                    "표는 가로 4열, 세로 10행입니다. 첫 번째 행(헤더)은 이미 고정되어 있으므로, " +
                "오직 데이터 행만 만들어주세요. 각 행은 'No.', '성명', '금액', '주소 및 기타' 순서의 4개의 열로 구성되어야 합니다."
          },
          {"role": "user", "content": rawText}
        ],
        "max_tokens": 1500
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey"
        },
        body: jsonEncode(requestPayload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final gptResponse = data['choices'][0]['message']['content'];
        print("GPT 응답: $gptResponse");
        _parseGPTResult(gptResponse);
      } else {
        throw Exception('GPT API 호출 실패: ${utf8.decode(response.bodyBytes)}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('GPT API 호출 중 오류 발생: $e')),
      );
    }
  }

  // GPT 응답 데이터를 표 데이터로 변환
  void _parseGPTResult(String gptResponse) {
    final lines = gptResponse.split('\n');
    List<List<String>> rows = [];

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || RegExp(r'^[|\-\s]+$').hasMatch(line)) continue;

      if (line.startsWith('|') && line.endsWith('|')) {
        final content = line.substring(1, line.length - 1);
        final cells = content.split('|').map((cell) => cell.trim()).toList();
        if (cells.length == 4) {
          rows.add(cells);
        }
      }
    }

    if (rows.isNotEmpty && rows.first[0].toLowerCase() == "no.") {
      rows.removeAt(0);
    }

    while (rows.length < 10) {
      rows.add(["", "", "", ""]);
    }

    setState(() {
      _tableData = rows.take(10).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: const Text(
          '디지털 온정',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 제거
      ),
      backgroundColor: Colors.white, // 본문 배경 색상 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('사진 선택'),
            ),
            const SizedBox(height: 16),
            if (_selectedImage != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performOCR,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('OCR 및 GPT 실행'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: _tableData.isNotEmpty
                    ? Table(
                        border: TableBorder.all(color: Colors.grey),
                        children: [
                          TableRow(
                            children: _header
                                .map(
                                  (cell) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cell,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          ..._tableData.map(
                            (row) => TableRow(
                              children: row.map((cell) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    cell,
                                    style: const TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "인식된 데이터가 없습니다.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
