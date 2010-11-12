
		function Particle() {
			this.x = Math.random() * canvas.width;
			this.y = Math.random() * canvas.height;

			this.xvel = Math.random() * 5 - 2.5;
			this.yvel = Math.random() * 5 - 2.5;
		}

		Particle.prototype.update = function() {
			this.x += this.xvel;
			this.y += this.yvel;

			this.yvel += 0.1;

			if (this.x > canvas.width || this.x < 0) {
				this.xvel = -this.xvel;
			}

			if (this.y > canvas.height || this.y < 0) {
				this.yvel = -this.yvel;
			}
		}

		function loop() {
			ctx.clearRect(0, 0, canvas.width, canvas.height);

			for(var i = 0; i < NUM_PARTICLES; i++) {
				particles[i].update();

				ctx.beginPath();
				ctx.moveTo(particles[i].x, particles[i].y);
				ctx.lineTo(particles[i].x - particles[i].xvel,
									 particles[i].y - particles[i].yvel);
				ctx.stroke();
				ctx.closePath();
			}

			setTimeout(loop, 10);
		}

		function loadParticles() {
			canvas = document.getElementById("cv");
			ctx = canvas.getContext("2d");
			for(var i = 0; i < NUM_PARTICLES; i++) {
				particles[i] = new Particle();
			}

			ctx.lineWidth = "2";
			ctx.strokeStyle = "rgb(255, 0, 0)";
			loop();
		}

		function getElementsByClass(searchClass,node,tag) {
			var classElements = new Array();
			if ( node == null )
				node = document;
			if ( tag == null )
				tag = '*';
			var els = node.getElementsByTagName(tag);
			var elsLen = els.length;
			var pattern = new RegExp("(^|\\s)"+searchClass+"(\\s|$)");
			for (i = 0, j = 0; i < elsLen; i++) {
				if ( pattern.test(els[i].className) ) {
					classElements[j] = els[i];
					j++;
				}
			}
			return classElements;
		}