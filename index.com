<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Babylon GLB Viewer</title>

    <script src="https://cdn.babylonjs.com/babylon.js"></script>
    <script src="https://cdn.babylonjs.com/loaders/babylonjs.loaders.min.js"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            overflow: hidden;
        }

        #renderCanvas {
            width: 100%;
            height: 100%;
            touch-action: none;
        }
    </style>
</head>

<body>

<canvas id="renderCanvas"></canvas>

<script>

const canvas = document.getElementById("renderCanvas");

const engine = new BABYLON.Engine(canvas, true);

const createScene = function () {

    const scene = new BABYLON.Scene(engine);

    scene.clearColor = new BABYLON.Color4(0.95,0.95,0.95,1);

    const camera = new BABYLON.ArcRotateCamera(
        "camera",
        Math.PI / 2,
        Math.PI / 2.5,
        10,
        BABYLON.Vector3.Zero(),
        scene
    );

    camera.attachControl(canvas, true);

    const light1 = new BABYLON.HemisphericLight(
        "light1",
        new BABYLON.Vector3(1,1,0),
        scene
    );

    const light2 = new BABYLON.DirectionalLight(
        "light2",
        new BABYLON.Vector3(0,-1,1),
        scene
    );

    BABYLON.SceneLoader.Append(
        "",
        "https://welspungroup-my.sharepoint.com/:u:/g/personal/wel_darpan_welspun_com/IQAl3vURakjaTaLxT04FyfgOAfnZqAQq-iu7hAJGHFeajY8?e=oAqxCZ",
        scene,
        function () {
            console.log("Model loaded");
        }
    );

    return scene;
};

const scene = createScene();

engine.runRenderLoop(function () {
    scene.render();
});

window.addEventListener("resize", function () {
    engine.resize();
});

</script>

</body>
</html>
