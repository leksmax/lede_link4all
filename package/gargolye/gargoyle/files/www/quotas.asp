#!/usr/bin/haserl
<%
	# This program is copyright © 2008,2009 Eric Bishop and is distributed under the terms of the GNU GPL
	# version 2.0 with a special clarification/exception that permits adapting the program to
	# configure proprietary "back end" software provided that all modifications to the web interface
	# itself remain covered by the GPL.
	# See http://gargoyle-router.com/faq.html#qfoss for more information
	eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "login.asp" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )
	gargoyle_header_footer -h -s "firewall" -p "quotas" -c "internal.css" -j "gs_sortable.js table.js quotas.js" -z "quotas.js" gargoyle firewall qos_gargoyle

%>

<script>
<!--
<%
	echo "var qosMarkList = [];"
	if [ -h /etc/rc.d/S50qos_gargoyle ] && [ -e /etc/qos_class_marks ]  ; then
		echo "var fullQosEnabled = true;"
		awk '{ print "qosMarkList.push([\""$1"\",\""$2"\",\""$3"\",\""$4"\"]);" }' /etc/qos_class_marks
	else
		echo "var fullQosEnabled = false;"
	fi

	print_quotas
%>
	var uci = uciOriginal.clone();
//-->
</script>

<h1 class="page-header"><%~ quotas.mQuotas %></h1>
<div class="row">
	<div class="col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><%~ quotas.Section %></h3>
			</div>

			<div class="panel-body">
				<div class="row form-group">
					<span class="col-xs-12" id="add_quota_label" style="text-decoration:underline"><%~ AddQuota %>:</span>
					<div>
						<%in templates/quotas_template %>
					</div>
					<span class="col-xs-12"><button id="add_quota_button" class="btn btn-default" onclick="addNewQuota()"><%~ AddQuota %></button></span>
				</div>

				<div id="internal_divider1" class="internal_divider"></div>

				<div class="row form-group">
					<span class="col-xs-12" id="active_quotas_label" style="text-decoration:underline"><%~ ActivQuotas %>:</span>
				</div>
				<div id="quota_table_container" class="table-responsive"></div>
			</div>
		</div>
	</div>
</div>

<div id="bottom_button_container" class="panel panel-default">
	<button id="save_button" class="btn btn-primary btn-lg" onclick="saveChanges()"><%~ SaveChanges %></button>
	<button id="reset_button" class="btn btn-warning btn-lg" onclick="resetData()"><%~ Reset %></button>
</div>
<span id="update_container" ><%~ WaitSettings %></span>

<!-- <br /><textarea style="margin-left:20px;" rows=30 cols=60 id="output"></textarea> -->

<script>
<!--
	resetData();
//-->
</script>

<%
	gargoyle_header_footer -f -s "firewall" -p "quotas"
%>
