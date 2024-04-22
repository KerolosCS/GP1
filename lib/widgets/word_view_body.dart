import 'package:flutter/material.dart';

class WordsViewBody extends StatelessWidget {
  const WordsViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> words = [
      'صفر',
      'واحد',
      'اثنين',
      'ثلاثه',
      'اربعه',
      'خمسه',
      'سته',
      'سابعه',
      'ثمانيه',
      
      'تسعه',
      'قائمة الطعام',
      'تفضل الطلب',
      'صداع مزمن',
      'ضغط عالي',
      'وجدت حقيبة',
      'كيف حالك',
      'سرقة حقيبة',
      'صباح الخير',
      'اين المحاضرة',
      'أريد قهوة',
      'رخصة قيادة',
      'مساء الخير',
      'موعد المحاضرة',
      'اريد الحساب',
      'مما تعاني',
      'أين المترو',
      'مبنى الامتحان',
      'اريد الفاتورة',
      'سرطان الحنجرة',
      'كيف اساعدك',
      'موعد النتيجة',
      'اريد المدير',
      'ضعف سمعي',
      'تقديم بلاغ'
    ];

    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            itemCount: words.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) {
              return GridTile(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: Text(words[index]),
                ),
              ));
            }),
      ),
    );
  }
}
