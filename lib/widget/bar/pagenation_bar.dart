import 'package:flutter/material.dart';
import 'package:outmatic/util/app_theme.dart';

class PagenationBar extends StatelessWidget {

  final int pageCount, currentPage;
  final Function(int) onPageSelected;

  PagenationBar({this.pageCount, this.currentPage, this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      color: AppTheme.primaryDarkColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: pageCount,
        itemBuilder: (context, index) => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (currentPage != index) {
                onPageSelected(index);
              }
            },
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: currentPage == index ? Colors.white : Colors.transparent
                  )
              ),
              child: Text("${index + 1}", style: TextStyle(color: currentPage == index ? Colors.white : Colors.black, fontSize: 18),),
            ),
          ),
        ),
      ),
    );
  }
}
