var obulding:Array = [];
var oostep:Array = [];
var placement:Array = [];
var v_name:Number = 0;
var v_cash:Number = 1;
var v_bankVar:Number = 2;
var v_hp:Number = 3;
var v_nowStep:Number = 4;
var v_AIplay:Number = 5;
var v_cards:Number = 6;
var v_stockown:Number = 7;
var v_mosterown:Number = 8;
// 0 player's name, 1 cash, 2 deposit, 3 hp, 4 nowstep, 5 ai/human true/false, 6  cards, 7 stock, 8 monster
pl1 = ["Heskeyo", 4000, 10000, 0, 0, false, [], [], []];
pl2 = ["John", 4000, 10000, 0, 0, true, [], [], []];
pl3 = ["Mans", 4000, 10000, 0, 0, true, [], [], []];
pl4 = ["Yoki", 4000, 10000, 0, 0, true, [], [], []];
//setting data======================================================================================================
pln = [pl1, pl4];
//======================================================================================================
function map2draw() {
	var BankShop:Number = 5;
	var weaponShop:Number = 14;
	var pdtoal:Number = 0;
	var sttotal:Number = 0;
	for (var i in c) {
		if (typeof (c[i]) == "movieclip") {
			if (i.substr(0, 2) == "ws") {
				c.attachMovie("placec", "proper"+pdtoal, pdtoal+103);
				c["proper"+pdtoal]._x = c["ws"+pdtoal]._x;
				c["proper"+pdtoal]._y = c["ws"+pdtoal]._y;
				pdtoal++;
			} else if (i.substr(0, 1) == "w") {
				sttotal++;
			} else {
				break;
				trace('error');
			}
		}
	}
	for (var i = 0; i<sttotal; i++) {
		oostep.push([c["w"+i]._x, c["w"+i]._y]);
	}
	for (var i = 0; i<pdtoal; i++) {
		if (BankShop === i) {
			c["proper"+i].gotoAndStop("special");
			c["proper"+i].attachMovie("shop0", "shop", 1);
			var basicproperty:Array = ["Shop_ban_"+i, c["ws"+i]._x, c["ws"+i]._y, "_", "_", true];
			//           00:name 01:x-co 02:y-co  03:owership 04:standon 05:instant event
			var st1 = random(100)+100;
			var st2 = random(1000)+100;
			var st3 = random(5000)+100;
			obulding.push([basicproperty, st1, st2, st3]);
		} else if (weaponShop === i) {
			c["proper"+i].gotoAndStop("special");
			c["proper"+i].attachMovie("shop1", "shop", 1);
			var basicproperty:Array = ["Shop_wea_"+i, c["ws"+i]._x, c["ws"+i]._y, "_", "_", false];
			//           00:name 01:x-co 02:y-co  03:owership 04:standon 05:instant event
			var st1 = random(100)+100;
			var st2 = random(1000)+100;
			var st3 = random(5000)+100;
			obulding.push([basicproperty, st1, st2, st3]);
		} else {
			var basicproperty:Array = ["proper"+i, c["ws"+i]._x, c["ws"+i]._y];
			//name , x , y            00:name      01:x-co       02:y-co
			var advanceproperty:Array = [false, 0, false];
			//                     03:owership 04:standon 05:instant event
			var st1 = random(100)+100;
			//stage level cost    01
			var st2 = random(1000)+100;
			//stage level cost    02
			var st3 = random(5000)+100;
			//stage level cost    03
			var st4 = random(6000)+100;
			//stage level cost    04
			var st5 = random(7000)+100;
			//stage level cost    05
			var st6 = random(10000)+100;
			//stage level cost    06
			var st7 = random(30000)+100;
			//stage level cost    07
			var st8 = random(50000)+100;
			//stage level cost    08
			var st9 = random(100000)+100;
			//stage level cost    09
			var st10 = random(1000000)+100;
			//stage level cost    10
			var longvalue = basicproperty.concat(advanceproperty);
			obulding.push([longvalue, st1, st2, st3, st4, st5, st6, st7, st8, st9, st10]);
		}
		//trace(obulding);
	}
	for (var i = 0; i<pln.length; i++) {
		//c.getNextHighestDepth()
		c.attachMovie("CA"+i, pln[i][0], 7000-i);
		this.c[pln[i][v_name]]._x = oostep[0][0];
		this.c[pln[i][v_name]]._y = oostep[0][1];
		this.c[pln[i][v_name]]._xscale = this.c[pln[i][v_name]]._yscale=50;
		//this.c[pln[i][0]].gotoAndStop("M1");
	}
}
//===================================================================
var diceout:Number = 0;
var dicnum:Number = 0;
var interval:Number = 0;
var p:Number = 0;
var days:Number = 0;
//===================================================================
var actionTerminated:Boolean = true;
//trace('maping......');
map2draw();
paper._visible = false;
_global.startScale = 800;
var sndeable:Boolean = true;
_global.fullvol = 100;
_global.halfvol = 25;
_global.e3.start(0, 9999);
var temporary:Boolean;
playerturn(0);
stop();
