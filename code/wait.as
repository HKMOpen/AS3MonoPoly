MovieClip.prototype.wait = function(seconds) {
	this._waiterGoOn = function(targetMC) {
		targetMC.play();
		clearInterval(targetMC._waiterInterval);
	};
	this._waiterInterval = setInterval(this._waiterGoOn, seconds*1000, this);
	this.stop();
};
ASSetPropFlags(MovieClip.prototype, "wait", 1, 0);
