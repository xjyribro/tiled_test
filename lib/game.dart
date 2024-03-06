import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:flutter/material.dart';

class GameWidgetWrapper extends StatelessWidget {
  const GameWidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: GomilandGame(),
    );
  }
}

class GomilandGame extends FlameGame {
  GomilandGame() : world = GomilandWorld() {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  @override
  World world;
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    addAll([
      world,
      cameraComponent,
    ]);}
}

class GomilandWorld extends World with HasGameRef<GomilandGame> {
  GomilandWorld({super.children});

  Future<void> _loadMap(TiledComponent map) async {
    final animationCompiler = AnimationBatchCompiler();
    final imageCompiler = ImageBatchCompiler();
    final layerNames = [
      'sand',
      'road',
      'pavement',
      'grass',
      'overlays',
      'barriers',
      'bases',
      'trees',
      'buildings',
    ];
    final ground = imageCompiler.compileMapLayer(
      tileMap: map.tileMap,
      layerNames: layerNames,
    );
    add(ground);
    await TileProcessor.processTileType(
        tileMap: map.tileMap,
        processorByType: <String, TileProcessorFunc>{
          'water': ((tile, position, size) async {
            return animationCompiler.addTile(position, tile);
          }),
        },
        layersToLoad: [
          'water',
        ]);
    final animatedWater = await animationCompiler.compile();
    animatedWater.priority = -1;
    add(animatedWater);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final TiledComponent map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(32),
    );
    await _loadMap(map);
    final Vector2 centerOfScene = Vector2(map.width / 2, map.height / 2);
    game.cameraComponent.viewfinder.zoom = 0.1;
    game.cameraComponent.moveTo(centerOfScene);
  }
}
