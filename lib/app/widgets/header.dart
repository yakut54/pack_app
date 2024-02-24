import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class Header extends StatelessWidget {
  final String packTitle;
  final String packSubtitle;
  final String? backgroundImg;

  const Header({
    super.key,
    required this.packTitle,
    required this.packSubtitle,
    this.backgroundImg,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = MediaQuery.of(context).size.width;
        BaseResponsiveSizing responsiveSizes = BaseResponsiveSizing(width);

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Container(
            alignment: Alignment.center,
            height: responsiveSizes.heightHeader,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.47),
                  blurRadius: 4,
                  offset: const Offset(2, 3),
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/images/${backgroundImg ?? 'bg_01'}.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: responsiveSizes.heightHeader,
                    maxWidth: width,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: const [0.6, 10, 1.0],
                      colors: [
                        const Color(0xFFF1F3FF).withOpacity(1.0),
                        const Color(0xFFF1F3FF).withOpacity(0.0),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 940,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: width,
                        constraints: BoxConstraints(
                          minHeight: responsiveSizes.heightHeader,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/arr.png"),
                                  fit: BoxFit.contain,
                                  alignment: Alignment(-1, 0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    packTitle.trim().replaceAll("\\n", "\n"),
                                    style: TextStyle(
                                        fontFamily: FontFamily.semiFont,
                                        fontSize: responsiveSizes.fontSizeHeaderLarge,
                                        height: 1,
                                        color: const Color(0xFFC09D52)),
                                  ),
                                  Text(
                                    packSubtitle.trim().replaceAll("\\n", "\n"),
                                    style: TextStyle(
                                        fontFamily: FontFamily.regularFont,
                                        fontSize: responsiveSizes.fontSizeHeaderSmall,
                                        height: 1.3,
                                        color: const Color(0xFF000000)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
