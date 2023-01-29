import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';



class twla extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<twla> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "https://firebasestorage.googleapis.com/v0/b/the-world-of-books-60b2e.appspot.com/o/Sports%2FNoor-Book.com%20%20%D9%83%D8%A7%D8%A8%D8%AA%D9%86%20%D8%A7%D8%B3%D8%A7%D9%85%D8%A9%20%D8%B3%D8%B9%D9%8A%D8%AF%20%D8%AD%D8%A7%D9%85%D8%AF%20%D8%A7%D9%84%D8%B5%D8%A8%D8%A7%D8%BA%20%D8%A7%D9%84%D8%AD%D8%AF%D9%8A%D8%AB%20%D9%81%D9%89%20%D8%AA%D8%B9%D9%84%D9%85%20%D8%AA%D9%86%D8%B3%20%D8%A7%D9%84%D8%B7%D8%A7%D9%88%D9%84%D8%A9%203%20.pdf?alt=media&token=f7eee91d-6d64-407e-875f-99b652c3263e";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,centerTitle: true,title: SizedBox(
        child:  Image.asset("images/pics/logo.png"),),),
      body: Container(width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/pics/twla.jpg"),fit: BoxFit.fill,
          )
        ),
        child: Column(
          children: <Widget>[SizedBox(height: 500),
            Container( child: RaisedButton(padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 48),
              color: Colors.black,
              splashColor: Colors.grey,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.grey),
              ),
              child: Text("Enjoy",style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontStyle: FontStyle.italic,
                  color: Colors.white,fontSize: 25)),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
              ),
            ),)
          ],
        )

      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(

        path: pathPDF);
  }
}