import 'package:flutter/material.dart';

class World extends StatefulWidget {
  const World({super.key});

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ParticleController pController = ParticleController();

  @override
  void initState() {
    super.initState();
    // Todo 初始化粒子管理器
    initParticleController();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(() {
        pController.update();
      });

    Future.delayed(const Duration(milliseconds: 1000),(){
      _controller.repeat();
    });
  }

  void initParticleController() {
    pController.size = Size(300, 200);
    Particle particle1 = Particle(
        x: -140,
        vy: 0,
        ay: 3.7 / 60,
        maxY: pController.size!.height,
        color: Colors.green,
        size: 8);

    Particle particle2 = Particle(
        x: -100,
        vx: 0,
        vy: 0,
        ay: 8.87 / 60,
        maxY: pController.size!.height,
        color: Colors.yellow,
        size: 8);

    Particle particle3 = Particle(
        x: -60,
        vy: 0,
        ay: 9.8 / 60,
        maxY: pController.size!.height,
        color: Colors.blue,
        size: 8);

    Particle particle4 = Particle(
        x: -20,
        vx: 0,
        vy: 0,
        ay: 3.71 / 60,
        maxY: pController.size!.height,
        color: Colors.red,
        size: 8);

    Particle particle5 = Particle(
        x: 20,
        vx: 0,
        vy: 0,
        ay: 24.79 / 60,
        maxY: pController.size!.height,
        color: Colors.cyan,
        size: 8);
    Particle particle6 = Particle(
        x: 60,
        vx: 0,
        vy: 0,
        ay: 10.44 / 60,
        maxY: pController.size!.height,
        color: Colors.orangeAccent,
        size: 8);
    Particle particle7 = Particle(
        x: 100,
        vx: 0,
        vy: 0,
        ay: 8.87 / 60,
        maxY: pController.size!.height,
        color: Colors.blueGrey,
        size: 8);
    Particle particle8= Particle(
        x: 140,
        vx: 0,
        vy: 0,
        ay: 11.15/ 60,
        maxY: pController.size!.height,
        color: Colors.blueAccent,
        size: 8);

    pController.particles = [
      particle1,
      particle2,
      particle3,
      particle4,
      particle5,
      particle6,
      particle7,
      particle8,
    ];
    // pController.p = particle3;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onTap() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 200,),
       Container(
         alignment: Alignment.center,
         child:  Text('从左到右：水-金-地-火-木-土-天王-海王',style: TextStyle(fontSize: 16),),
       ),
        CustomPaint(
        size: Size(300,200),
    painter: _BallMove(controller: pController),
    )
      ],
    );
  }
}

class _BallMove extends CustomPainter {
  //
  final ParticleController controller;
  Paint ballPaint = Paint();
  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  // 实现刷新
  _BallMove({required this.controller}) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(150, 20);
    canvas.save();
    canvas.translate(0, controller.size!.height / 2);

    // 小球运动区域
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero,
            width: controller.size!.width,
            height: controller.size!.height),
        stokePaint);
    canvas.restore();

    //
    // ballPaint.color = controller.p.color;
    // canvas.drawCircle(Offset(controller.p.x, controller.p.y),
    //     controller.p.size, ballPaint);

    controller.particles.forEach((particle) {
      drawParticle(canvas, particle);
    });
  }

  void drawParticle(Canvas canvas, Particle particle) {
    ballPaint.color = particle.color;
    canvas.drawCircle(Offset(particle.x, particle.y), particle.size, ballPaint);
  }

  @override
  bool shouldRepaint(covariant _BallMove oldDelegate) {
    return false;
  }
}

// 粒子对象
class Particle {
  double x; // x 位移.

  double y; // y 位移.
  double initY; // y 位移.

  double ax; // 粒子水平加速度

  double ay; // 粒子竖直加速度

  double vx; // 粒子水平速度.

  double maxY;
  double vy; //粒子竖直速度.

  double size; // 粒子大小.

  Color color; // 粒子颜色.

  Particle({
    this.x = 0,
    this.y = 0,
    this.initY = 0,
    this.ax = 0,
    this.ay = 0,
    this.vx = 0,
    this.vy = 0,
    this.size = 0,
    this.maxY = 0,
    this.color = const Color(0xff000000),
  });
}

// 粒子控制器
class ParticleController with ChangeNotifier {
  // 粒子集合
  List<Particle> particles = [];
  late Particle p;
  Size? size;

  ParticleController();

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void update() {
    particles.forEach(doUpdate);
    notifyListeners();
  }

  void doUpdate(Particle p) {
    // 一秒刷新60次
    // 距离= 时间 * 速度。
    // 自由落体 速度不断加快，地球加速度9.8/s
    // s = t * v；
    p.y += p.vy;
    p.vy += p.ay;
    if (p.y > size!.height) {
      p.maxY = p.maxY * 0.8;
      p.y = size!.height;
      // 假设能量损失 反弹速度为弹起的4/5
      p.vy = -p.vy * 0.8;
    }
    if (p.y < size!.height - p.maxY) {
      p.y = size!.height - p.maxY;
      p.vy = 0;
    }

    // if (p.maxY < 0.01) {
    //   p.y = p.initY;
    //   p.maxY = size!.height;
    // }
    notifyListeners();
  }
}
