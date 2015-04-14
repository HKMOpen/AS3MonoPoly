function GoSart(x:Number) {
	placement = [];
	for (var i = 0; i<x; i++) {
		pln[p][v_nowStep]++;
		var ustep:Number = pln[p][v_nowStep];
		var numd:Number = oostep.length;
		ustep %= numd;
		pln[p][v_nowStep] = ustep;
		//trace([step, oostep.length]);
		var npx = oostep[ustep][0];
		var npy = oostep[ustep][1];
		placement.push([npx, npy, ustep]);
	}
	c[pln[p][v_name]].onEnterFrame = objrun;
}
function upto() {
	//instant
	var b = placement[0][2];
	if (placement.length>1) {
		//trace(placement);
		if (obulding[b][0][5] == true) {
			//trace("instant");
			temporary = true;
			eventToHappen(b);
			c[pln[p][0]].onEnterFrame = null;
		}
		placement.shift();
	} else {
		temporary = false;
		c[pln[p][0]].onEnterFrame = null;
		eventToHappen(b);
	}
}
function focus() {
	var k:String = pln[p][v_name];
	var b1:Number = c[k]._x*_global.startScale/100;
	var b2:Number = c[k]._y*_global.startScale/100;
	var x:Number = -b1-c._x+550/2;
	var y:Number = -b2-c._y+400/2;
	var t:Number = Math.sqrt(Math.pow(y, 2)+Math.pow(x, 2));
	var r:Number = Math.atan2(y, x);
	c._x += Math.cos(r)*t*.2;
	c._y += Math.sin(r)*t*.2;
	//var m1 = math1(distx);
	//var m2 = math1(disty);
	//var a2 = (b2-c._y)*.125
	//var a1 = (b1-c._x)*.125
	//c._x = -(b1+m1)+550/2;
	//c._y = -(b2+m2)+400/2;
}
MovieClip.prototype.objrun = function(x) {
	distx = placement[0][0]-this._x;
	disty = placement[0][1]-this._y;
	var totaldist:Number = Math.sqrt(Math.pow(disty, 2)+Math.pow(distx, 2));
	var r:Number = Math.atan2(disty, distx);
	var ang:Number = r*180/Math.PI;
	if (ang>360) {
		ang -= 360;
	}
	if (ang<0) {
		ang += 360;
	}
	this.telly._rotation = ang;
	if (ang>45 && ang<135) {
		//    |
		//    |
		//    v
		this.gotoAndStop("M3");
	} else if (ang>135 && ang<225) {
		//
		//  <----
		//
		this.gotoAndStop("M2");
	} else if (ang>225 && ang<315) {
		//    ^
		//    |
		//    |
		this.gotoAndStop("M4");
	} else if (ang>315 || ang<45) {
		//
		//   ---->
		//
		this.gotoAndStop("M1");
	} else {
		this.gotoAndStop("M1");
	}
	//sp -= 0.1
	//if (sp<1) {sp = 1}
	this._x += Math.cos(r)*2;
	this._y += Math.sin(r)*2;
	if (Math.floor(Math.abs(totaldist)) == 0) {
		upto();
	}
	//trace([this._x, this._y, placement[1][1], distx, totaldist])
};
function dice(x:String) {
	switch (x) {
	case 'on' :
		dicnum = random(6);
		interval = setInterval(function () {
			dicnum++;
			dicnum %= 6;
			diceout = dicnum+1;
		}, 50);
		break;
	case 'pick' :
		clearInterval(interval);
		break;
	}
}
var tx_3 = new TextFormat();
tx_3.bold = false;
tx_3.color = 0x00ff00;
tx_3.size = 12;
tx_3.bullet = false;
var tx_4 = new TextFormat();
tx_4.bold = true;
tx_4.color = 0xff0000;
tx_4.size = 12;
tx_4.bullet = false;
function playerturn(playNO:Number) {
	playNO %= pln.length;
	//var mc0:MovieClip = this.c[pln[playNO][v_name]];
	//mc0.getNextHighestDepth();
	//var thisLV = mc0.getDepth();
	//for (var i = 0; i<pln.length; i++) {
	///var mc:MovieClip = this.c[pln[i][v_name]];
	//mc.getInstanceAtDepth(thisLV-i);
	//trace(thisLV-1-i);instanceName.swapDepths(
	//}
	this.go._visible = false;
	this.bgwhite.gotoAndPlay(1);
	la = "";
	dice('on');
	showTextInfoOfplayer(playNO);
	var isAIPlaying:Boolean = pln[playNO][v_AIplay];
	if (isAIPlaying) {
		var pick:Number = setInterval(function () {
			sfx("e1");
			dice('pick');
			GoSart(diceout);
			// la = diceout;
			clearInterval(pick);
		}, 1000+random(1000));
	} else {
		this.go._visible = true;
	}
	p = playNO;
}
this.onEnterFrame = function() {
	focus();
	gdp.text = pln[p];
	c._xscale = c._yscale=_global.startScale;
};
this.go.onRelease = function() {
	this._visible = false;
	//trace(actionTerminated)
	//if (actionTerminated) {
	sfx("e1");
	dice('pick');
	GoSart(diceout);
	//la = dicnum;
};
this.seag0.onRelease = function() {
	this._visible = false;
	panelcontrol.play()
};
