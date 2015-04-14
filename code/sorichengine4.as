var rent:Number = 0;
var tx_1 = new TextFormat();
tx_1.bold = true;
tx_1.color = 0xffffff;
tx_1.size = 12;
tx_1.bullet = false;
var tx_2 = new TextFormat();
tx_2.bold = true;
tx_2.color = 0x000000;
tx_2.size = 20;
tx_2.bullet = false;
var buildupLv = function (lv:Number, mo:Number, need:Number) {
	setbgmVol(0);
	tellTarget ("paper") {
		gotoAndStop("q3");
		_visible = true;
		canBeUpgrate_1 = true;
		canBeUpgrate_2 = true;
		canBeUpgrate_3 = true;
		canBeUpgrate_4 = true;
		od.text = "";
		od.text += "If you wanna to extend you achitecture to "+lv+"LV for "+mo+"G\n";
		od.text += "Appromixately that would use "+Math.floor(need/mo*100)+"%\n";
		od.text += "Are you confident on building it up?";
		od.setTextFormat(tx_2);
	}
};
var eventToHappen = function (now_step:Number) {
	var 銀行 = function () { tellTarget ("bank") {gotoAndStop("a");_visible = true;}};
	var 武器店 = function () { tellTarget ("bank") {gotoAndStop("k0");_visible = true;}};
	var 購地 = function () { setbgmVol(_global.halfvol);tellTarget ("paper") {gotoAndStop("q1");notok._visible = false;_visible = true;od.text = "";od.text += "你要用"+_root.dec2(Number(o2/nowmoney*100))+"% 的現金購得此地嗎？\n";od.text += "地名 "+placename+"\n";od.text += "售價 "+o2+"G\n";od.text += "過路費 "+100+"G\n";od.text += "stage 1 "+o3+"G\n";od.text += "stage 2 "+o4+"G\n";od.text += "stage 3 "+o5+"G\n";od.text += "stage 4 "+o6+"G\n";od.text += "stage 5 "+o7+"G\n";od.text += "stage 6 "+o8+"G\n";od.text += "stage 7 "+o9+"G\n";od.text += "stage 8 "+o10+"G\n";od.text += "stage 9 "+o11+"G\n";od.setTextFormat(tx_1);}};
	var 撽費或開戰 = function () { _global.mmc.start(0, 30);setbgmVol(0);tellTarget ("paper") {gotoAndStop("q2");_visible = true;od.text = "";od.text += "撽交租金 "+r+"G\n";od.text += "大概為現有資金的"+_root.dec2(Number(r/nowmoney*100))+"%\n";od.text += "你決定要予 "+ownership+" "+r+"G";od.setTextFormat(tx_2);}};
	var display_the_message = function (x:String) { tellTarget ("paper") {gotoAndPlay("mess");_visible = true;od.text = x;od.setTextFormat(tx_1);}};
	var AI:Boolean = pln[p][5];
	var l = obulding[now_step];
	var nowmoney:Number = pln[p][1];
	var nowsavedmoney:Number = pln[p][2];
	var placename:String = String(l[0][0]);
	var nameq:String = placename.substring(5, 8);
	var nowowner:String = pln[p][0];
	var ownership = l[0][3];
	var o2:Number = Number(parseInt(l[1])*10);
	var o3:Number = parseInt(l[2]);
	var o4:Number = parseInt(l[3]);
	var o5:Number = parseInt(l[4]);
	var o6:Number = parseInt(l[5]);
	var o7:Number = parseInt(l[6]);
	var o8:Number = parseInt(l[7]);
	var o9:Number = parseInt(l[8]);
	var o10:Number = parseInt(l[9]);
	var o11:Number = parseInt(l[10]);
	var now_level_home:Number = parseInt(l[0][4]);
	var nextLv:Number = now_level_home+1;
	var nextLvMoney:Number = l[nextLv];
	if (!AI) {
		if (placename.substr(0, 4) == "Shop") {
			_global.mmu.start(0, 30);
			setbgmVol(0);
			if (nameq == "ban") {
				銀行();
			}
			if (nameq == "wea") {
				武器店();
			}
		} else if (placename.substr(0, 6) == "proper") {
			if (now_level_home == 0) {
				rent = 100+o2/2;
			} else {
				rent = int(l[now_level_home]/2+now_level_home*l[now_level_home]/10);
			}
			var r = rent;
			if (!ownership) {
				購地();
			} else if (ownership != nowowner) {
				撽費或開戰();
			} else if (ownership == nowowner) {
				buildupLv(nowmoney, nextLv, nextLvMoney);
			} else {
				workingCompleted();
			}
		}
	} else if (AI == true) {
		var displaytxt = "";
		if (placename.substr(0, 4) == "Shop") {
			if (nameq == "ban") {
				if (nowmoney>50000) {
					var cash = random(40000)+10000;
					displaytxt = nowowner+" has deposited "+cash+" G.";
					depositM(cash);
				} else if (nowmoney<0) {
					var essentialmoney = -(nowmoney);
					var cash = random(nowsavedmoney*0.8)+essentialmoney+nowsavedmoney*0.2;
					displaytxt = nowowner+" has withdrown "+cash+" G.";
					depositG(cash);
				} else if (nowmoney>0 && nowmoney<5000) {
					var cash = nowsavedmoney*0.30;
					displaytxt = nowowner+" got "+cash+" G.";
					depositG(cash);
				} else if (nowmoney<50000 && nowmoney>5000) {
					displaytxt = "Nothing to do... \n Wait until next turn for luck.";
				}
			} else if (nameq == "wea") {
				displaytxt = "Nothing to do... \n Wait until next turn for luck.";
			}
		} else if (placename.substr(0, 6) == "proper") {
			if (now_level_home == 0) {
				rent = 100+o2/2;
			} else {
				rent = int(l[now_level_home]/2+now_level_home*l[now_level_home]/10);
			}
			if (ownership == false) {
				var moneyneed = Number(parseInt(l[1])*10);
				if (nowmoney>=moneyneed) {
					displaytxt = nowowner+" purchased "+placename+".\n "+o2+" was used to pay the place.";
					buyhome(false);
				} else {
					// displaytxt = "Nothing to do... \n Wait until next turn for luck.";
					displaytxt = "Nothing to do....";
				}
			} else if (ownership != nowowner) {
				displaytxt = nowowner+" give "+ownership+" for "+rent+" G as rent \n"+ownership+" gain the rent "+rent+" G.";
				payForRent(false);
			} else if (ownership == nowowner) {
				if (nowmoney>=nextLvMoney) {
					// displaytxt = nowowner+" buildupLv房舍至 LEVEL "+nextLv+"。\n動用了資金"+nextLvMoney+" Ｇ。";
					displaytxt = nowowner+"The square was used for building extention.\n "+ownership+" upgrated it to "+nextLv+"LV \nIt involed with "+nextLvMoney+"G on the extention.";
					upgrateHome();
				} else {
					displaytxt = "Nothing to do....";
					// displaytxt = "Nothing to do... \n Wait until next turn for luck.";
				}
			} else {
				displaytxt = "Nothing to do....";
				// displaytxt = "Nothing to do... \n Wait until next turn for luck.";
			}
		}
		display_the_message(String(displaytxt));
	}
};
