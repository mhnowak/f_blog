import 'package:jaspr/jaspr.dart';

import '../components/counter.dart';

@client
class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      img(src: 'images/logo.svg', width: 80),
      h1([text('Welcome')]),
      p([text('You successfully create a new Jaspr site.')]),
      div(styles: Styles(height: 100.px), []),
      const Counter(),
    ]);
  }
}
