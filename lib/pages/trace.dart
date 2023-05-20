import 'package:flutter/material.dart';

class TracePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Card(),
          Card(),
          Card(),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [Icon(Icons.motorcycle), Text('2023年5月15日')],
          ),
          Row(
            children: [
              Image.asset('images/dots.png'),
              Column(
                children: [const Text('北京大兴区京良路'), const Text('郭公庄(地铁站)')],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text('2.8km'),
                  const Text('导航里程'),
                ],
              ),
              Column(
                children: [
                  const Text('00:06'),
                  const Text('驾驶时长'),
                ],
              ),
              Column(
                children: [
                  const Text('25km/h'),
                  const Text('平均速度'),
                ],
              ),
              Column(
                children: [
                  const Text('72km/h'),
                  const Text('最快速度'),
                ],
              ),
              Column(
                children: [
                  const Text('2.26元'),
                  const Text('预估油费'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
