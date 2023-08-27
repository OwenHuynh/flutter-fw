import 'package:components/res/spacing_alias.dart';
import 'package:components/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flutter/material.dart';

class EmployeesLoading extends StatelessWidget {
  const EmployeesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(SpacingAlias.Spacing12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerRectangle(size: Size(200, 20)),
                    SpacingAlias.SizeHeight8,
                    const ShimmerRectangle(size: Size(80, 20)),
                    SpacingAlias.SizeHeight8,
                    const ShimmerRectangle(
                      size: Size(180, 20),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
