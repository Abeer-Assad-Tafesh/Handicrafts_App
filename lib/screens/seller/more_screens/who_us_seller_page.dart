import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/all_appBar.dart';



class WhoUsSellerPage extends StatelessWidget {
  const WhoUsSellerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              AllAppBar(text: 'من نحن',back: true,logo: false,),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة،'
                      ' لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص '
                      'أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق\t'
                      'إذا كنت تحتاج إلى عدد أكبر من الفقرات.\n يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد'
                      ' النص لن يبدو مقسما ولا يحوي أخطاء لغوية.\n'
                      ' مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص،'
                      ' \nحيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.\n'
                      '\n.ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،\n'
                      'دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق.'
                      ' هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم'
                      '. لأنه مازال نصاً بديلاً ومؤقتاً.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
