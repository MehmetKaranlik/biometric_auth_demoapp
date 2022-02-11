import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

import '../../../core/extensions/context_extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: _buildCard(context),
          ),
        ));
  }

  GlassContainer _buildCard(BuildContext context) {
    return GlassContainer.frostedGlass(
        borderRadius: BorderRadius.all(Radius.circular(context.widthFraction * 5)),
        height: context.heightFraction * 20,
        width: context.widthFraction * 80,
        child: Padding(
          padding: EdgeInsets.all(context.widthFraction * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUpperRow(context),
              const Spacer(),
              _buildCardNumber(context),
              SizedBox(height: context.heightFraction * 1),
              _buildBottomRow(context)
            ],
          ),
        ));
  }

  Row _buildBottomRow(BuildContext context) {
    return Row(
      children: [
        Text(
          "Eddie Brook",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.grey[500],
              ),
        ),
        const Spacer(),
        Text(
          "01/03",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.grey[500],
              ),
        )
      ],
    );
  }

  Text _buildCardNumber(BuildContext context) {
    return Text(
      "XXXX XXXX XXXX XXXX",
      style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.grey[500],
          ),
    );
  }

  Row _buildUpperRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.fingerprint_rounded,
          size: context.heightFraction * 5,
          color: Colors.grey[500],
        ),
        const Spacer(),
        Text(
          "Visa",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.grey[500],
              ),
        )
      ],
    );
  }
}
