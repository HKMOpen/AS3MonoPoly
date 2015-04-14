/*--------------------------------------------------------------------
Array.Contains(value)

A function to find if value is contained inside the array anywhere...

Author:
David B. (david@jmbsoftware.net)
Date:
July 13, 2003
Version:
0.1a
License:
As is! You assume all responsibility for this code.
Use as you see fit. Use at your own risk!

Inputs:
[value] = the value to find inside the array.
Returns:
[int] = the number of occurrence of that [value] inside the array.

Example:
var a;
var cnt;
a = new Array(1,2,3,3,3,4);
cnt = a.Contains(3);
trace(cnt);
------------------------------------------------------------------------*/
Array.prototype.Contains = function(value) {
	var found = 0;
	var i = 0;
	for (i=0; i<this.length; i++) {
		if (this[i] == value) {
			found++;
		}
	}
	return found;
};
//_root.myarray=["a","b","c","d"]
//_root.myarray=_root.myarray.shuffle()
Array.prototype.shuffle = function() {
	var o = this.slice();
	var l = o.length;
	var n = new Array();
	for (var i = 0; i<l; ++i) {
		var r = random(o.length);
		n[n.length] = o[r];
		o[r] = o[o.length-1];
		o.pop();
	}
	return n;
};
//lets start the function
//here is the array
//var myArray = new Array(1, 3, 6, 7, 7, 3, 12, 33, 34, 43, 44, 44, 7);
//run the function
//myArray.statistics();
Array.prototype.statistics = function() {
	//lets create our variables here
	var type;
	var sum = 0;
	var mean;
	var median;
	var mode_;
	var count;
	var preCount;
	//this function will put the numbers in order from smallest to greatest
	function sortNumbers(element1, element2) {
		return element1-element2;
	}
	//run the sort
	this.sort(sortNumbers);
	//this will get the average of the elements within the array called the mean
	for (var i = 0; i<this.length-1; i++) {
		sum += this[i];
		mean = sum/this.length;
		//this is an optional rounding method
		mean = Math.round(mean);
	}
	//this will determine if the amount of elements is an odd or even number
	//and store it in the type variable
	if ((this.length/2) != (Math.floor(this.length/2))) {
		type = "odd";
	} else {
		type = "even";
	}
	//lets get the middle number of the array called the median
	if (type == "odd") {
		median = Math.round(this[(this.length-1)/2]);
		//if the amount is odd, it simply grabs the center number, but if it is
		//even, it must grab the two center numbers and average them
	} else if (type == "even") {
		median = (this[(this.length)/2]+this[(this.length/2)-1])/2;
	}
	//this will determine the frequency of each element and return the most frequent
	var preCount = 1;
	var count = 0;
	for (var i = 0; i<=this.length-1; i++) {
		for (var j = (i+1); j<=this.length-1; j++) {
			if (this[i] == this[j]) {
				preCount += 1;
				//the next code will determine if the amount of the element its meauring is larger
				//than the previous one
				if (preCount>count) {
					count = preCount;
					preCount = 1;
					mode_ = this[i];
				}
			}
		}
	}
	//I set the answers to trace in the output window on the test screen
	trace("mean = "+mean);
	trace("median = "+median);
	trace("mode = "+mode_);
};
//function by missing-link
//Create the function
getMax = function (tmpArray:Array) {
	var tmpMax = 0;
	for (var i = 0; i<tmpArray.length; i++) {
		if (tmpArray[i]>tmpMax) {
			tmpMax = tmpArray[i];
		}
	}
	return tmpMax;
};
getMin = function (tmpArray:Array) {
	var tmpMin = getMax(tmpArray);
	for (var i = 0; i<tmpArray.length; i++) {
		if (tmpArray[i]<tmpMin) {
			tmpMin = tmpArray[i];
		}
	}
	return tmpMin;
};
/*Copy the script and run the flash movie*/
//
//
//returns an array containing random numbers, the random numbers can be unique, they can have a range and you can specify how many random numbers you want in your array
//
//_root.myuniquerandomnumbers=Number.randomnumbers(10,20,10,true)
//
function randomnumbers(lowest:Number, highest:Number, count:Number, unique:Boolean) {
	var randomnums = new Array();
	if (unique && count<=highest-lowest) {
		var nums = new Array();
		for (var i = lowest; i<=highest; ++i) {
			nums.push(i);
		}
		for (var i = 1; i<=count; ++i) {
			var randomnumber = Math.floor(Math.random()*nums.length);
			randomnums.push(nums[randomnumber]);
			nums.splice(randomnumber, 1);
		}
	} else {
		for (var i = 1; i<=count; ++i) {
			randomnums.push(lowest+Math.floor(Math.random()*(highest-lowest)));
		}
	}
	return randomnums;
}
//to make some number that no repeat
//minVal=最小值範圍
//maxVal=最大值範圍
//nTimes=造出數字之數目
function RRRandom(minVal:Number, maxVal:Number, nTimes:Number) {
	var nReturn = new Array(nTimes-1);
	for (var c = 0; c<=nTimes-1; c++) {
		nReturn[c] = minVal+Math.floor(Math.random()*(maxVal+1-minVal));
		for (var x = 0; x<=c-1; x++) {
			if (nReturn[c] == nReturn[x]) {
				nReturn[c] = "";
				--c;
			}
		}
	}
	return nReturn;
}
//
//format a number into specified number of decimal places
function formatDecimals(num:Number, digits:Number) {
	// if no decimal places needed, we're done
	if (digits<=0) {
		return Math.round(num);
	}
	// round the number to specified decimal places
	// e.g. 12.3456 to 3 digits (12.346) -> mult. by 1000, round, div. by 1000
	var tenToPower = Math.pow(10, digits);
	var cropped = String(Math.round(num*tenToPower)/tenToPower);
	// add decimal point if missing
	if (cropped.indexOf(".") == -1) {
		cropped += ".0";
		// e.g. 5 -> 5.0 (at least one zero is needed)
	}
	// finally, force correct number of zeroes; add some if necessary
	var halves = cropped.split(".");
	// grab numbers to the right of the decimal
	// compare digits in right half of string to digits wanted
	var zerosNeeded = digits-halves[1].length;
	// number of zeros to add
	for (var i = 1; i<=zerosNeeded; i++) {
		cropped += "0";
	}
	return (cropped);
}
//Robert Penner May 2001 - source@robertpenner.com
//set number to 2 decimal places
//You can set this anywhere in your timeline and use as you need anywhere in your movie.
//a = 0.5;
//b = 0.8;
//z = Math.dec2(5);
//if you trace thism, z will display "5.00"
//z = Math.dec2(a + b);
//if you trace thism, z will display "1.30"
//
//
function dec2(num:Number) {
	var valor = String(Math.round(num*100)/100);
	var dot = valor.indexOf(".");
	if (dot == -1) {
		valor += ".0";
	}
	var temp = valor.split(".");
	var addDecimals = 2-temp[1].length;
	for (i=1; i<=addDecimals; i++) {
		valor += "0";
	}
	return Number(valor);
}
//
/*排序
//Array.prototype.bubble help
//tester = [54, 6, 1, 346, 32, 55, 3, 66, 28];
//trace("original array :"+tester);
//tester1 = new Array();*/
/*tester1 = tester.bubble();
trace("bubbleed array:"+tester);
original array :54,6,1,346,32,55,3,66,28
arrray's length:9
bubbleed array:1,3,6,28,32,54,55,66,346
*/
Array.prototype.bubble = function() {
	var arr_t = new Array();
	var count = this.length;
	//trace("arrray's length:"+count);
	var temp = 0;
	for (var i = count-1; i>0; i--) {
		for (var j = 0; j<i; j++) {
			if (this[j]>this[j+1]) {
				temp = this[j];
				this[j] = this[j+1];
				this[j+1] = temp;
			}
		}
	}
	return this;
};
//function sortN(arr:Array) {...} help
//temp = new Array(1, 25, 101, 23, 52, 52, 92, 4);
//temp = sortN(temp);
//trace(temp);//1,4,23,25,52,52,92,101
//
function sortN(arr:Array) {
	var tmp = new Array();
	tmp[0] = arr[0];
	var num;
	for (var i = 1; i<arr.length; i++) {
		num = arr[i];
		var done = false;
		for (var j = 0; j<tmp.length; j++) {
			if (((num>tmp[j]) && (num<tmp[j+1])) || (num == tmp[j])) {
				tmp.splice(j+1, 0, num);
				done = true;
				break;
			}
		}
		if ((!done) && (num<tmp[0])) {
			tmp.unshift(num);
		} else if ((!done) && (num>tmp[tmp.length-1])) {
			tmp.push(num);
		}
	}
	return tmp;
}
function arrJ2gether(x1:Array, x2:Array) {
	if (x1.length>=x2.length) {
		var xlong = x1.length;
	} else {
		var xlong = x2.length;
	}
	//x1.length+x2.length;
	var c:Array = [];
	for (var i = 0; i<xlong; i++) {
		c.push(x1[i], x2[i]);
	}
	return c;
}
//customer math
function math1(x:Number) {
	return Math.sin(x*x)*x/10;
}
function math2(x:Number) {
	return x*x/50;
}
function math3(x:Number) {
	if (actionTerminated) {
		return x*x/50;
	} else {
		return 0;
	}
}
