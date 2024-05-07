$(document).ready(function(){
    var canvas = document.getElementById("canvas");
    if (!canvas) return;
    var context = canvas.getContext("2d");
    var resolution = window.devicePixelRatio || 1;
  
    var waves = [];
    var resized = false;
  
    var vw, vh;
    resizeCanvas();
  
    var wave1 = createWave(context, {
      amplitude: 50,
      duration: 2,
      fillStyle: "rgba(13,128,242,0.2)",
      frequency: 2.5,
      width: vw,
      height: vh,
      segments: 100,
      waveHeight: vh * 0.92
    });
  
    var wave2 = createWave(context, {
      amplitude: 75,
      duration: 7,
      fillStyle: "rgba(13,128,242,0.2)",
      frequency: 2,
      width: vw,
      height: vh,
      segments: 100,
      waveHeight: vh * 0.92
    });
  
    var wave3 = createWave(context, {
      amplitude: 50,
      duration: 6,
      fillStyle: "rgba(13,128,242,0.2)",
      frequency: 2.5,
      width: vw,
      height: vh,
      segments: 100,
      waveHeight: vh * 0.92
    });
  
    var wave4 = createWave(context, {
      amplitude: 75,
      duration: 4,
      fillStyle: "rgba(13,128,242,0.2)",
      frequency: 2,
      width: vw,
      height: vh,
      segments: 100,
      waveHeight: vh * 0.92
    });
  
    waves.push(wave1, wave2, wave3, wave4);
  
    TweenMax.to(waves, 10, {
      waveHeight: vh,
      ease: Sine.easeInOut,
      repeat: -5,
      repeatDelay: 0,
      yoyo: true
    });
  
    TweenMax.to(wave1, 6, {
      amplitude: 10,
      ease: Sine.easeInOut,
      repeat: -20,
      yoyo: true
    });
  
    TweenMax.to(wave2, 7, {
      amplitude: 25,
      ease: Sine.easeInOut,
      repeat: -15,
      yoyo: true
    });
  
    TweenMax.to(wave3, 5, {
      amplitude: 15,
      ease: Sine.easeInOut,
      repeat: -5,
      yoyo: true
    });
  
    TweenMax.to(wave4, 3, {
      amplitude: 20,
      ease: Sine.easeInOut,
      repeat: -1,
      yoyo: true
    });
  
    window.addEventListener("resize", function() {
      resized = true;
    });
  
    TweenLite.ticker.addEventListener("tick", update);
  
    function update() {
      
      var len = waves.length;
      
      if (resized) {
        
        resizeCanvas();
        
        for (var i = 0; i < len; i++) {
          waves[i].resize(vw, vh);
        }
        
        resized = false;
      }
      
      context.clearRect(0, 0, vw, vh);  
      context.globalCompositeOperation = "soft-light";
      
      for (var i = 0; i < len; i++) {
        waves[i].draw();
      }
    }
  
    function createWave(context, options) {
      
      options = options || {};
      
      // API
      var wave = {
        
        // Properties
        amplitude: options.amplitude || 200,
        context: context,
        curviness: options.curviness || 0.75,
        duration: options.duration || 2,
        fillStyle: options.fillStyle || "rgba(33,150,243,1)",
        frequency: options.frequency || 4,
        height: options.height || 600,
        points: [],
        segments: options.segments || 100,
        tweens: [],
        waveHeight: options.waveHeight || 300,
        width: options.width || 800,
        x: options.x || 0,
        y: options.y || 0,
        
        // Methods
        init: init,
        resize: resize,
        draw: draw,
        kill: kill
      };
      
      init();
        
      function kill() {
        
        var tweens = wave.tweens;
        var len = tweens.length;
        
        for (var i = 0; i < len; i++) {
          tweens[i].kill();
        }
        
        tweens.length = 0;
        wave.points.length = 0;
      }
      
      function init() {
        
        kill();
        
        var segments = wave.segments;
        var interval = wave.width / segments;
        
        for (var i = 0; i <= segments; i++) {
          
          var norm = i / segments;
          var point = {
            x: wave.x + i * interval,
            y: 1
          };
          
          var tween = TweenMax.to(point, wave.duration, {
            y: -1,
            repeat: -1,
            yoyo: true,
            ease: Sine.easeInOut
          }).progress(norm * wave.frequency)
          
          wave.tweens.push(tween);
          wave.points.push(point);
        }    
      }
      
      function draw() {
        
        var points = wave.points;
        var len = points.length;
        
        var startY = wave.waveHeight;
        var height = wave.amplitude / 2;
        
        context.beginPath();    
        context.moveTo(points[0].x, startY + points[0].y * height);
        
        for (var i = 1; i < len; i++) {
          
          var point = points[i];
          context.lineTo(point.x, startY + point.y * height);
        }
        
        context.lineTo(wave.x + wave.width, wave.y + wave.height);
        context.lineTo(wave.x, wave.y + wave.height);
        context.closePath();
        context.fillStyle = wave.fillStyle;
        context.fill();
      }
      
      function resize(width, height) {
        
        wave.width = width;
        wave.height = height;
        
        var points = wave.points;
        var len = points.length;
        var interval = wave.width / wave.segments;
        
        for (var i = 0; i < len; i++) {
          
          var point = points[i];
          point.x = wave.x + i * interval;
        }
      }
      
      return wave;
    }
  
    function resizeCanvas() {
      
      vw = window.innerWidth;
      vh = window.innerHeight;
        
      canvas.width  = vw * resolution;
      canvas.height = vh * resolution;
      
      canvas.style.width  = vw + "px";
      canvas.style.height = vh + "px";
      
      context.scale(resolution, resolution);
    }
  });