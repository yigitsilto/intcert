import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/logo.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'KURULUŞ PROFİLİ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                child: const Text(
                  'CTR Uluslararası Belgelendirme ve Denetim Ltd. Şti., bağımsız ve tarafsız özel bir belgelendirme kuruluşudur. 90’lı yılların başından bu yana sektörün içinde olan ekibimizin deneyimleri bir araya getirilerek 2005 yılında kurulmuştur. Uygunluk Değerlendirmesi Derneği (UDDER) üyesi olan CTR, Ankara ve İstanbul’daki ofislerinde faaliyetlerini güven ve değer yaratma üzerine kurulu bir hizmet anlayışıyla sürdürmektedir. Faaliyet alanlarımız; Eğitim Belgelendirme: (Sertifika/ Karne/ Diploma/ Seminer/ Konferans Programları Düzenleyen Kurum ve Kuruluşlar)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            
             
            ],
          ),
        ),
      ),
    );
  }
}
