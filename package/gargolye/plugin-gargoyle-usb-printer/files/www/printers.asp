#!/usr/bin/haserl
<%
	# This program is copyright © 2008-2013 Eric Bishop and is distributed under the terms of the GNU GPL
	# version 2.0 with a special clarification/exception that permits adapting the program to
	# configure proprietary "back end" software provided that all modifications to the web interface
	# itself remain covered by the GPL.
	# See http://gargoyle-router.com/faq.html#qfoss for more information
	eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "login.asp" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )
	gargoyle_header_footer -h -s "system" -p "printers" -c "internal.css"
%>

<script>
<%
	printer_id=$(uci get p910nd.@p910nd[0].printer_name 2>/dev/null)
	ipaddr=$(uci get network.lan.ipaddr 2>/dev/null)
	echo "var printerId=\"$printer_id\";"
	echo "var routerIp=\"$ipaddr\";"
%>
	resetData = function()
	{
		document.getElementById("no_printer_div").style.display = printerId == "" ? "block" : "none"
		document.getElementById("printer_found_div").style.display = printerId == "" ? "none" : "block"
		setChildText( "printer_id", printerId )
		setChildText( "router_ip",  routerIp  )
	}

</script>

<h1 class="page-header"><%~ print.Attch %></h1>
<div id="no_printer_div" class="row">
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><%~ print.Attch %></h3>
			</div>

			<div class="panel-body">
				<em><%~ NoPrnt %></em>
			</div>
		</div>
	</div>
</div>

<div id="printer_found_div" class="row">
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><%~ print.Attch %></h3>
			</div>

			<div class="panel-body">
				<p><strong><span id="printer_id"></span> <%~ ConnU %></strong></p>
				<p><%~ ConnIP %> <span id="router_ip"></span> <%~ JetProto %></p>
			</div>
		</div>

	</div>
</div>

<script>
<!--
	resetData();
//-->
</script>
<%
	gargoyle_header_footer -f -s "system" -p "printers"
%>

