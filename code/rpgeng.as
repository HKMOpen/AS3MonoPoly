function loadbgm() {
}
//prototype
Array.prototype.copy = function() {
	return this.slice();
};
Array.prototype.calla = function(c:Number) {
	this = "fighter00"+c;
	return this.slice();
};
//all use
// first set of listeners
var mcload:MovieClipLoader = new MovieClipLoader();
var listens:Object = new Object();
listens.onLoadStart = function(mc:MovieClip) {
	trace("*********First mcload instance*********");
	trace("Your load has begun on movie clip = "+mc);
	var loadProgress:Object = mcload.getProgress(mc);
	trace(loadProgress.bytesLoaded+" = bytes loaded at start");
	trace(loadProgress.bytesTotal+" = bytes total at start");
};
listens.onLoadProgress = function(mc:MovieClip, loadedBytes:Number, totalBytes:Number) {
	trace("*********First mcload instance Progress*********");
	trace("onLoadProgress() called back on movie clip "+mc);
	trace(loadedBytes+" = bytes loaded at progress callback");
	trace(totalBytes+" = bytes total at progress callback");
	loadboard.deb.text = loadedBytes+' / '+totalBytes;
};
listens.onLoadComplete = function(mc:MovieClip) {
	trace("*********First mcload instance*********");
	trace("Your load is done on movie clip = "+mc);
	var loadProgress:Object = mcload.getProgress(mc);
	trace(loadProgress.bytesLoaded+" = bytes loaded at end");
	trace(loadProgress.bytesTotal+" = bytes total at end");
	loadboard.deb.text = 'loading succeeded';
	loadboard.gotoAndStop('s');
};
listens.onLoadInit = function(mc:MovieClip) {
	trace("*********First mcload instance*********");
	trace("Movie clip = "+mc+" is now initialized");
	// you can now do any setup required, for example:
	mc._width = 200;
	mc._height = 200;
	soundr('display');
	var cd:Object = mcload.getProgress(mc);
	var cd0:Number = cd.bytesTotal;
	var cdst:String = cd0.toString();
	var cd1:Number = random(190)+10;
	var cd2:Number = Math.floor(parseInt(cdst.substring(cdst.length-3, cdst.length-1)));
	//attack
	var cd3:Number = Math.floor(cd2*2/3)+random(10);
	var cd4:Number = Math.floor(cd2*2/3+10);
	var cd5:Number = Math.floor(cd2*2/3-2);
	var cd6:Number = Math.floor(cd2*2/3*5-20);
	var cd7:Number = Math.floor(cd2*1000/3+100);
	var cd8:Number = 50;
	fighter[0] = [cd1, cd1, cd2, cd2, cd3, cd4, cd5, cd7, cd8, 0, 0, 0, 0, 0, 0, 0];
	//========================================================|-------------|
};
listens.onLoadError = function(mc:MovieClip, errorCode:String) {
	trace("*********First mcload instance*********");
	trace("ERROR CODE = "+errorCode);
	trace("Your load failed on movie clip = "+mc+"\n");
	loadboard.deb.text = "ERROR CODE = "+errorCode;
	loadboard.gotoAndStop('a');
};
//========================new game data================================//
//9:status 0: normal 1:ice 2:posion 3:power up 4:super power
//==========================================|
var mp = 2;
var hp = 0;
var flee = 15;
var accura = 16;
var attack = 4;
var shield = 5;
var defence = 6;
var timerun = 7;
var healvar = 8;
var LV = 17;
//dynamic
var power = 10;
var statusvar = 9;
//==========================================|
fighter = new Array();
fighter[0] = [0700, 1000, 0500, 0500, 000000010, 0000, 0000003, 920, 00020, 0, 0, 0, 0, 0, 0, .01, .89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
fighter[1] = [1000, 1500, 0600, 0600, 00000003, 0000, 0000003, 00620, 000030, 0, 0, 0, 0, 0, 0, .03, .55, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//============0:hp==1:hp==2:MP==3:MP==4:Attack===5:sh==6:de=====7:ale===8:heal value=====================================//
var dimtime:Number = 0;
var timesofbattle:Number = 0;
//for battle interval
function battleFX(x:Number, functionnorty:String):Void {
	if (x == 0) {
		var h = act0._height;
	} else {
		var h = beast._height;
	}
	switch (functionnorty) {
	case 'fitch' :
		//attack fitch
		this.attachMovie('axo', 'axo', 15000);
		this.axo._x = this['b'+x]._x;
		this.axo._y = this['b'+x]._y-h/2;
		this.axo._rotation = random(180);
		soundr('hit');
		break;
	case 'heal' :
		//heal
		this.attachMovie('healll', 'healll', 15001);
		this.healll._x = this['b'+x]._x;
		this.healll._y = this['b'+x]._y-h/2-30;
		soundr('uplv');
		break;
	case 'ice' :
		fighter[x][statusvar] = 1;
		this.attachMovie('ice', 'status_ic', 15002);
		this.status_ic._x = this['b'+x]._x;
		this.status_ic._y = this['b'+x]._y;
		this.status_ic._alpha = 32;
		soundr('bbice');
		break;
	case 'healAllItem' :
		fighter[x][statusvar] = 0;
		this.attachMovie('healh', 'healh', 15003);
		this.healh._x = this['b'+x]._x;
		this.healh._y = this['b'+x]._y+5;
		this.healh._alpha = 50;
		this.status_ic.removeMovieClip();
		soundr('uplv');
		break;
	case 'sword' :
		this.attachMovie('swd', 'swd', 15004);
		this.swd._x = this['b'+x]._x;
		this.swd._y = this['b'+x]._y-h/2;
		this.swd._xscale = this.swd._yscale=h/2;
		this.swd._rotation = random(60)+90;
		soundr('swdd');
		break;
	case 'cano' :
		this.attachMovie('canogun', 'canogun', 15005);
		this.canogun._x = this['b'+x]._x;
		this.canogun._y = this['b'+x]._y-h/2;
		this.canogun._alpha = 90;
		if (x == 1) {
			this.canogun._xscale = -100;
		}
		soundr('gunbig');
		break;
	case 'miss' :
		this.attachMovie('missed', 'mis', 15006);
		this.mis._alpha = 90;
		//this.mis.gotoAndPlay(1);
		this.mis._x = this['b'+x]._x;
		this.mis._y = this['b'+x]._y;
		soundr('misia');
		break;
	case 'smokingon' :
		var mcname:String = 'smok'+x;
		this.attachMovie('somma', mcname, 14500+x);
		this[mcname]._alpha = 90;
		//this.mis.gotoAndPlay(1);
		this[mcname]._x = this['b'+x]._x;
		this[mcname]._y = this['b'+x]._y;
		soundr('sommas');
		break;
	case 'smokingoff' :
		var mcname:String = 'smok'+x;
		this[mcname].play();
		soundr('sommas');
		break;
	case 'magicbaseOn' :
		this['b'+x].utr._visible = true;
		soundr('upmagic');
		break;
	case 'magicbaseOFF' :
		this['b'+x].utr._visible = false;
		break;
	}
}
function healviamp(x:Number) {
	if (Number(fighter[x][hp]+fighter[x][8])>fighter[x][1]) {
		fighter[x][hp] = fighter[x][1];
	} else {
		fighter[x][hp] += fighter[x][healvar];
	}
	fighter[x][mp] -= Math.floor(fighter[x][healvar]*1.3);
	battleFX(x, 'heal');
}
function attacknormal(a:Number, b:Number) {
	//a add the attack on b || a ------> b
	fighter[b][hp] -= fighter[a][attack];
	battleFX(b, 'fitch');
}
function attacksword(a:Number, b:Number) {
	//a add the attack on b || a ------> b
	fighter[b][hp] -= Math.floor(fighter[a][attack]*1.5);
	battleFX(b, 'sword');
}
//top element
function attackswordsp(a:Number, b:Number) {
	//a add the attack on b || a ------> b
	// use power && mp
	fighter[b][hp] -= Math.floor(fighter[a][attack]*fighter[a][power]);
	fighter[a][power] -= 40;
	fighter[a][mp] -= 30;
	battleFX(b, 'sword');
	battleFX(b, 'sword');
}
function attackcannon(a:Number, b:Number) {
	//a add the attack on b || a ------> b
	//use mp && power
	fighter[b][hp] -= Math.floor(fighter[a][attack]*10*Number(random(10)+1));
	fighter[a][power] -= 40;
	fighter[a][mp] -= 30;
	battleFX(a, 'cano');
}
function deter() {
	if (fighter[0][hp]<=0) {
		showboard.gotoAndPlay("lost");
		soundr('lost')
	} else if (fighter[1][hp]<=0) {
		showboard.gotoAndPlay("won");
		soundr('won')
	}
}
function watch(x1:Number, x2:Number) {
	//     ||||   target, function||||========================================================
	//watch HP
	if (fighter[x1][hp]<=0 || fighter[x2][hp]<=0) {
		clearInterval(dimtime);
		play();
	} else if (fighter[x1][statusvar] != 0) {
		if (fighter[x1][statusvar] == 1 && fighter[x1][2]>5) {
			fighter[x1][2] -= 5;
			battleFX(x1, 'healAllItem');
		} else if (fighter[x1][power]>30) {
			fighter[x1][power] -= 30;
			battleFX(x1, 'healAllItem');
		} else {
			fighter[e1][power] += 3;
			soundr('icee');
		}
	} else if ((fighter[x1][0]/fighter[x1][1])<.3 && fighter[x1][mp]>Math.floor(fighter[x1][healvar]*1.3)) {
		//attack function group
		healviamp(x1);
	} else {
		//check accurra
		var probability:Number = Math.random();
		var var_P:Number = fighter[x1][accura]-fighter[x2][flee];
		trace([probability, fighter[x1][accura], fighter[x2][flee]]);
		if (probability>var_P) {
			battleFX(x2, 'miss');
		} else {
			var methoduse:Number = random(10)+1;
			if (fighter[x1][power]>10) {
				if (methoduse == 4 && fighter[x1][mp]>10) {
					fighter[x1][mp] -= 10;
					battleFX(x2, 'ice');
				} else {
					if (fighter[x1][power]>30) {
						battleFX(x1, 'smokingon');
						if (x1 == 0) {
							attacksword(x1, x2);
						}
						if (fighter[x1][power]>40 && fighter[x1][mp]>30) {
							if (methoduse>5) {
								attackswordsp(x1, x2);
							} else {
								attackcannon(x1, x2);
							}
						}
					} else {
						battleFX(x1, 'smokingoff');
					}
				}
			} else {
				attacknormal(x1, x2);
			}
		}
	}
	//===================================================================|
	//watch MP
	//
	fillintheblank(1, blank0);
	fillintheblank(0, blank1);
}
function fillintheblank(z:Number, blank:TextField) {
	var c = fighter[z];
	//trace(c);
	var texttype:String = 'HP value = '+c[hp]+'/'+c[1]+', MP = '+c[mp]+'/'+c[3]+', PAttack = '+c[attack]+', SH = '+c[5]+', DE = '+c[6]+', power = '+c[power];
	blank.text = texttype;
}
function fillintheblank2(z:Number) {
	var c = fighter[z];
	//trace(c);
	var texttype:String = 'HP value = '+c[hp]+'/'+c[1]+',\n MP = '+c[mp]+'/'+c[3]+',\n PAttack = '+c[attack]+',\n SH = '+c[5]+',\n DE = '+c[6];
	return texttype;
}
function soundr(x:String) {
	snd = new Sound(this);
	snd.attachSound(x);
	snd.start();
}
function autofight() {
	timesofbattle = 0;
	var e1 = 0;
	dimtime = setInterval(function () {
		// IO setting
		e1 = timesofbattle;
		e1 %= 2;
		if (e1 == 0) {
			e2 = 1;
		} else if (e1 == 1) {
			e2 = 0;
		}
		// trace(e1);
		// power up
		fighter[e1][power] += Math.ceil(fighter[e1][attack]*.1);
		watch(e1, e2);
		timesofbattle++;
	}, fighter[e1][timerun]);
}
