//action blanks
function workingCompleted() {
	var closeall = function () {
		_global.mmu.stop();
		_global.mmc.stop();
		setbgmVol(_global.fullvol);
		if (bank._visible == true) {
			bank.gotoAndStop("empty");
			bank._visible = false;
		}
		if (paper._visible == true) {
			paper.gotoAndStop("empty");
			paper._visible = false;
		}
	};
	if (temporary) {
		closeall();
		c[pln[p][0]].onEnterFrame = objrun;
	} else {
		closeall();
		days++;
		playerturn(days);
	}
}
function upgrateHome() {
	var l = obulding[pln[p][4]];
	var levelst:Number = l[0][4];
	if (pln[p][1]>=l[levelst+1]) {
		//home set upgrate
		for (var i in c[l[0][0]]) {
			if (typeof ([i]) == "movieclip" && i != "building") {
				c[l[0][0]][i].removeMovieClip();
			}
		}
		c[l[0][0]].attachMovie("pl"+Number(levelst+1), "building", 200+p);
		//c[l[0][0]].fg.getInstanceAtDepth(10);
		c[l[0][0]].fg._x = 4;
		c[l[0][0]].fg._y = 5;
		c[l[0][0]].fg._yscale = c[l[0][0]].fg._xscale=75;
		//money --
		pln[p][1] -= l[levelst+1];
		//home level ++
		l[0][4]++;
		showTextInfoOfplayer(p);
		/*if (paper.canBeUpgrate_1) {
									//moneyChk
									paper.canBeUpgrate_1 = false;
								} else {
									paper.notok._visible = true;
								}
							} else {
								var tx_2 = new TextFormat();
								tx_2.bold = true;
								tx_2.color = 0x000000;
								tx_2.size = 20;
								tx_2.bullet = false;
								paper.od.text = "You have upgrated already.";
								paper.od.setTextFormat(tx_2);*/
	}
}
function payForRent(mclose:Boolean) {
	var l = obulding[pln[p][4]];
	if (pln[p][1]>=0) {
		pln[p][1] -= rent;
		for (var i = 0; i<pln.length; i++) {
			if (pln[i][v_name] == l[0][v_hp]) {
				pln[i][v_cash] += rent;
			}
		}
	} else {
		for (var i = 0; i<pln.length; i++) {
			if (pln[i][v_name] == l[0][v_hp]) {
				pln[i][v_cash] += rent;
			}
		}
		pln[p][2] -= rent;
	}
	showTextInfoOfplayer(p);
	paper._visible = false;
	if (mclose) {
		workingCompleted();
	}
}
function fightForRent() {
	var l = obulding[pln[p][4]];
}
function buyhome(mclose:Boolean) {
	var land = obulding[pln[p][4]];
	//cash
	var money:Number = pln[p][1];
	var moneyneed:Number = land[1]*10;
	//moneyChk
	if (money>=moneyneed) {
		//set face
		c[land[0][0]].gotoAndStop("owed");
		c[land[0][0]].attachMovie("flag"+p, "fg", 100);
		//buy the owership
		land[0][3] = pln[p][0];
		//money --
		pln[p][1] -= Math.floor(moneyneed);
		//alert off
		paper._visible = false;
		//action finished
		if (mclose) {
			workingCompleted();
		}
		showTextInfoOfplayer(p);
	} else {
		paper.notok._visible = true;
	}
}
function showTextInfoOfplayer(player:Number) {
	PlayerName.text = pln[player][v_name];
	if (pln[player][v_cash]>0) {
		Money.text = "Cash: "+pln[player][v_cash]+"G";
		Money.setTextFormat(tx_3);
	} else {
		Money.text = "Cash: "+pln[player][v_cash]+"G";
		Money.setTextFormat(tx_4);
	}
	Deposit.text = "Deposit: "+pln[player][v_bankVar]+"G";
}
function DE_display() {
	return Math.floor(pln[p][2]);
}
function CA_display() {
	return Math.floor(pln[p][1]);
}
function ca_percent(e:Number) {
	var m = pln[p][1];
	return Math.floor(e/100*Number(m));
}
function de_percent(e:Number) {
	var m = pln[p][2];
	return Math.floor(e/100*Number(m));
}
//depposit money
function depositM(e:Number) {
	if (e<1) {
		break;
	} else {
		pln[p][1] -= Math.floor(e);
		pln[p][2] += Math.floor(e);
		showTextInfoOfplayer(p);
	}
}
//get money
function depositG(e:Number) {
	if (e<1) {
		break;
	} else {
		pln[p][1] += Math.floor(e);
		pln[p][2] -= Math.floor(e);
		showTextInfoOfplayer(p);
	}
}
//=================================control panel========================================
function sfx(x) {
	if (sndeable) {
		_global[x].start(0, 1);
	}
}
function setbgmVol(vol:Number) {
	_global.e3.setVolume(vol);
}
function copymovieclipactor(how:String) {
	if (how == 'on') {
		this.attachMovie("CA"+p, "displayedpeople", 700);
		this.displayedpeople._xscale = this.displayedpeople._yscale=800;
		this.displayedpeople._x = 400;
		this.displayedpeople._y = 250;
		this.panelcontrol.areatee.text = "Name: "+pln[p][v_name]+"\nCash: "+pln[p][v_cash]+"G \nDeposit: "+pln[p][v_bankVar]+"G";
	} else {
		this.displayedpeople.removeMovieClip();
		this.panelcontrol.areatee.text = '';
	}
}
