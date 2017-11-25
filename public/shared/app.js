	function setCalc(curr,quan,usd,btc,btcBidTot,btcLasTot,usdBidTot){
		html = '<table class="table table-striped small">';
		html += '<tr><td align="right"><b>BTC-'+curr+'</b></td><td>' + btc +' BTC</td></tr>';
		html += '<tr><td align="right"><b>Tot Bid</td><td></b>' +btcBidTot+' BTC | '+usdBidTot+' USDT</td></tr>';
		html += '</table>';
		//,btc,btcBidTot,btcLasTot,usdBidTot,usdLasTot
		$('#currencyCalc').html(html);
		return false;
	}

	function setTrade(curr,units,bid){
		$('#currencyCalc').html(curr);
		$('#trUnits').val(units);
		$('#trBid').val(bid);
		return false;
	}
