<style type="text/css">

.callflows-port .media_tabs {
	background-color: #555555;
	border: 1px solid #363636;
	min-height: 90px;
	padding: 10px;
	position:relative;
	overflow-x: auto;
	white-space: nowrap;
}
.callflows-port .media_tabs .buttons {
	width: 128px;
	height: 90px;
	line-height: 90px;
	display: inline-block;
	position: relative;
	margin: 0 10px 0 0;
	text-align: center;
	-moz-border-radius: 12px;
	-webkit-border-radius: 12px;
	border-radius: 4px;
	cursor: pointer;
	opacity: 0.4;
	background: #3E7A8C;
	background: -moz-linear-gradient(top,  #3E7A8C 0%, #0099b7 25%, #008ca8 50%, #0099b7 75%, #3E7A8C 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#3E7A8C), color-stop(25%,#0099b7), color-stop(50%,#008ca8), color-stop(75%,#0099b7), color-stop(100%,#3E7A8C));
	background: -webkit-linear-gradient(top,  #3E7A8C 0%,#0099b7 25%,#008ca8 50%,#0099b7 75%,#3E7A8C 100%);
	background: -o-linear-gradient(top,  #3E7A8C 0%,#0099b7 25%,#008ca8 50%,#0099b7 75%,#3E7A8C 100%);
	background: -ms-linear-gradient(top,  #3E7A8C 0%,#0099b7 25%,#008ca8 50%,#0099b7 75%,#3E7A8C 100%);
	background: linear-gradient(to bottom,  #3E7A8C 0%,#0099b7 25%,#008ca8 50%,#0099b7 75%,#3E7A8C 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3E7A8C', endColorstr='#3E7A8C',GradientType=0 );
}
.callflows-port .media_tabs .buttons:hover {
	-moz-box-shadow: 3px 5px 10px #383838;
	-webkit-box-shadow: 3px 5px 10px #383838;
	box-shadow: 3px 5px 10px #383838;
	opacity: 0.6;
}
.callflows-port .media_tabs .buttons.current, 
.callflows-port .media_tabs .buttons.current:hover {
	-moz-box-shadow: 3px 5px 10px #383838;
	-webkit-box-shadow: 3px 5px 10px #383838;
	box-shadow: 3px 5px 10px #383838;
	opacity: 1;
}
.callflows-port .media_tabs .buttons .label_device {
	font-size: 12px;
	text-transform: uppercase;
	font-weight: bold;
	color: white;
}
.callflows-port #device-view .realm_label {
	line-height: 22px;
}
.callflows-port .media_pane {
	margin-left: 0;
	margin-top: 30px;
}
.callflows-port #device-form .provisioner select {
	width: 100px;
	margin-left: 10px;
}
.callflows-port #device-form .provisioner {
	display: inline-block;
	margin-left: 22px;
}
.callflows-port #user-form input[disabled=disabled] {
	background: #ccc;
}
.callflows-port #user-form #equipment {
	text-align: center;
	font-size: 12px;
	font-family: 'Helvetica';
}
.callflows-port #user-form #equipment .help_box {
	color: #333333;
	line-height: 12px;
}
.callflows-port #user-form #equipment .add_device {
	margin-top: 15px;
	display: inline-block;
}
.callflows-port #user-form #equipment .add_device:hover a {
	color: #333333;
}
.callflows-port #user-form #equipment .add_device:hover .add_device_icon {
	background-position: 0 -24px;
	cursor: pointer;
}
.callflows-port #user-form #equipment #tab_devices  {
	border: 2px solid #666666;
	border-radius: 15px 15px 15px 15px;
	color: #666666;
	margin: 20px auto auto;
	width: 560px;
}
.callflows-port #user-form #equipment #tab_devices .action_device {
	color: #666666;
	cursor: pointer;
	text-decoration: underline;
	line-height: 30px;
}
.callflows-port #user-form #equipment #tab_devices .action_device:not(:first-child) {
	margin-left: 10px;
}
.callflows-port #user-form #equipment #tab_devices .action_device:hover {
	color: #3E7A8C;
}
.callflows-port #user-form #equipment #tab_devices .column:not(.fifth) {
	border-right: 1px solid #A6A6A6;
}
.callflows-port #user-form #equipment #tab_devices .column {
	float: left;
	text-align: center;
	height: 30px;
	line-height: 30px;
}
.callflows-port #user-form #equipment #tab_devices .column.first {
	width: 190px;
	overflow: hidden;
	text-align:center;
}
.callflows-port #user-form #equipment #tab_devices .column.second {
	width: 99px;
}
.callflows-port #user-form #equipment #tab_devices .column.third {
	min-width: 49px;
}
.callflows-port #user-form #equipment #tab_devices .rows .column.third {
	background-image: url(../submodules/../style//lib/images/callflow/red_phone.png);
	background-repeat: no-repeat;
	background-position: 16px center;
}
.callflows-port #user-form #equipment #tab_devices .rows .column.third.registered,.callflows-port #user-form #equipment #tab_devices .rows .column.third.cellphone {
	background-image: url(../submodules/../style//lib/images/callflow/green_phone.png);
}
.callflows-port #user-form #equipment #tab_devices .rows .column.third.disabled {
	background-image: url(../submodules/../style//lib/images/callflow/gray_phone.png) !important;
}
.callflows-port #user-form #equipment #tab_devices .column.fourth {
	width: 59px;
}
.callflows-port #user-form #equipment #tab_devices .column.fourth .enabled_checkbox {
	margin-top: 8px;
}
.callflows-port #user-form #equipment #tab_devices .column.fifth {
	width: 159px;
}
.callflows-port #user-form #equipment #tab_devices .column.merged {
	width: 560px;
	border-right: none;
}
.callflows-port #user-form #equipment #tab_devices .row {
	height: 30px;
	margin-left: 0px;
}
.callflows-port #user-form #equipment #tab_devices .row.title {
	background-color: #dddddd !important;
	border-bottom: 2px solid #666666 !important;
	border-radius: 15px 15px 0px 0px;
	font-weight: bold;
}
.callflows-port #user-form #equipment #tab_devices .row:not(:last-child) {
	border-bottom: 1px solid #A6A6A6;
}
.callflows-port #user-form #equipment #tab_devices .row:last-child {
	border-radius: 0px 0px 15px 15px;
}
.callflows-port #user-form #equipment #tab_devices .row:nth-child(odd) {
	background-color: #eeeeee;
}
.callflows-port #user-form #equipment #tab_devices .row:nth-child(even) {
	background-color: #dddddd;
}
.callflows-port #user-form #username_label {
	color: #3E7A8C;
	text-align: left;
	font-weight: bold;
}
.callflows-port #user-form #hotdesk_devices {
	
	width: 320px;
}
.callflows-port #user-form #hotdesk_devices .row .column:nth-child(1) {
	width: 300px;
}
.callflows-port #user-form #hotdesk_devices .row .column:nth-child(2) {
	width: 80px;
}
.callflows-port #user-form #hotdesk_devices .row .column.merged {
	
	width: 320px;
}
.callflows-port #user-form #hotdesk_devices .row input[type="checkbox"] {
	margin-top: 10px;
}
.callflows-port #two_columns {
	padding-bottom: 20px;
}
.callflows-port #two_columns .wrapper {
	clear: left;
	width: 520px;
	padding: 10px;
}
.callflows-port #two_columns .wrapper_form {
	margin-top: 20px;
	margin-left: 40px;
}
.callflows-port #two_columns .wrapper .column {
	width: 220px;
	padding: 6px 0px 5px;
	background: #444;
	border-radius: 6px;
}
.callflows-port #two_columns .wrapper .column.right {
	float: right;
	margin-left: 10px;
}
.callflows-port #two_columns .wrapper .column.left {
	float: left;
	margin-right: 10px;
}
.callflows-port #two_columns .wrapper .title_column {
	background-color: #AFAFAF;
	height: 28px;
	line-height: 28px;
	font-weight: bold;
	font-size: 14px;
	text-align: center;
	margin-bottom: 3px;
}
.callflows-port #two_columns .wrapper .left ul.connect {
	background-color: #444444;
	height: 289px;
	width: 220px;
	overflow: auto;
	float: left;
}
.callflows-port #two_columns .wrapper .connect {
	min-height: 289px;
}
.callflows-port #two_columns .wrapper .right ul.connect {
	background-color: #444444;
	height: 289px;
	width: 220px;
	overflow: auto;
}
.callflows-port #two_columns .wrapper li {
	list-style-type: none;
	background-color: #AFAFAF;
	color: #444;
	display: block;
	height: 28px;
	line-height: 28px;
	list-style-type: none;
	overflow: hidden;
	position: relative;
	cursor: default;
}
.callflows-port #two_columns .wrapper li:not(:first-child) {
	border-top: 1px solid #444;
}
.callflows-port #two_columns .item_name {
	float:left;
	overflow: hidden;
	height: 28px;
	line-height: 28px;
	width: 155px;
	font-size: 12px;
	white-space: nowrap;
}
.callflows-port #two_columns .item_name.right {
	width: 120px;
}
.callflows-port #two_columns .wrapper li:hover {
	background-color: #cccccc;
}
.callflows-port #two_columns .wrapper li a.drag_btn {
	float: left;
	height: 28px;
	width: 7px;
	margin-right: 5px;
	margin-left: 1px;
}
.callflows-port #two_columns .options {
	float: right;
	margin-right: 2px;
	padding-left: 4px;
	border-left: 1px solid #444444;
	height: 28px;
}
.callflows-port #two_columns .options .option {
	width: 30px;
	font-size: 12px;
	margin-top: 2px;
	height: 20px;
}
.callflows-port #two_columns .ring_group_form_wrapper {
	display: block;
	margin: auto;
	width: 260px;
}
.callflows-port #two_columns .form_field_div {
	width: 260px;
}
.callflows-port #two_columns .button_field_div {
	margin: 20px 0px 5px;
	text-align: center;
}
.callflows-port .search_box {
	height: 28px;
	background-color:#444444;
	padding-top: 7px;
	border-bottom: 1px solid #222;
}
.callflows-port .search_box .searchsubmit1 {
	float: left;
	height: 20px;
	width: 23px;
}
.callflows-port .search_box .searchsubmit2 {
	float: left;
	height: 20px;
	width: 26px;
}
.callflows-port .search_box .searchfield {
	border: medium none;
	float: left;
	height: 14px;
	width: 130px;
	border-radius: 0px;
	box-shadow: none;
}
.callflows-port .search_box .searchfield:focus {
	border: none;
	border-color: transparent;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
}
.callflows-port#fax_callflow_popup #t_38_checkbox {
	margin-top: 8px;
}
.callflows-port form .input a {
	color: #3E7A8C;
	font-size: 13px;
	line-height: 30px;
}
.callflows-port #faxbox-form .tooltip {
	display: inline-block;
	float: none;
	margin-left: 5px;
}
.callflows-port #faxbox-form span.text {
	color: #22a5ff;
	font-size: 13px;
	font-weight: bold;
	line-height: 30px;
}
.callflows-port #directory-form #basic #tab_users  {
	border: 2px solid #666666;
	border-radius: 15px 15px 0px 0px;
	color: #666666;
	margin: 20px auto auto;
	width: 480px;
	max-height: 342px;
	float: left;
}
.callflows-port #directory-form #basic #tab_users .rows {
	max-height: 310px;
	overflow: auto;
}
.callflows-port #directory-form #basic #tab_users .action_user {
	color: #666666;
	cursor: pointer;
	text-decoration: underline;
	line-height: 32px;
}
.callflows-port #directory-form #basic #tab_users .action_user:not(:first-child) {
	margin-left: 10px;
}
.callflows-port #directory-form #basic #tab_users .action_user:hover {
	color: #3E7A8C;
}
.callflows-port #directory-form #basic #tab_users .column.first:not(:last-child) {
	border-right: 1px solid #A6A6A6;
}
.callflows-port #directory-form #basic #tab_users .column {
	float: left;
	text-align: center;
	height: 32px;
	line-height: 32px;
}
.callflows-port #directory-form #basic #tab_users select {
	height: 22px;
}
.callflows-port #directory-form #basic #tab_users .column.first {
	width: 230px;
	overflow: hidden;
	text-align:center;
}
.callflows-port #directory-form #basic #tab_users .column.third {
	width: 69px;
}
.callflows-port #directory-form #basic #tab_users .column.second {
	min-width: 159px;
	border-right: 1px solid #A6A6A6;
}
.callflows-port #directory-form #basic #tab_users .column.second select {
	margin: 0;
	max-width: 140px;
	padding: 0;
}
.callflows-port #directory-form #basic #tab_users .column.merged {
	width: 480px;
}
.callflows-port #directory-form #basic #tab_users .row-user {
	height: 32px;
	margin-left: 0px;
}
.callflows-port #directory-form #basic #tab_users .row-user.title {
	background-color: #dddddd !important;
	border-bottom: 2px solid #666666 !important;
	border-radius: 13px 13px 0px 0px;
	font-weight: bold;
}
.callflows-port #directory-form #basic #tab_users .row-user:not(:last-child) {
	border-bottom: 1px solid #A6A6A6;
}
.callflows-port #directory-form #basic #tab_users .row-user:nth-child(odd) {
	background-color: #eeeeee;
}
.callflows-port #directory-form #basic #tab_users .row-user:nth-child(even) {
	background-color: #dddddd;
}
.callflows-port #directory-form #basic .add_user {
	margin: 20px 0 0 20px;
	color: #666666;
	background: #666666;
	width: 230px;
	border-radius: 15px 15px 15px 15px;
	float: right;
}
.callflows-port #directory-form #basic .add_user .add_content_wrapper {
	background: #EEEEEE;
	border-radius: 0 0 15px 15px;
}
.callflows-port #directory-form #basic .add_user .add_user_title {
	color: #eeeeee;
	font-weight: bold;
	height: 25px;
	line-height: 25px;
	text-align: center;
	border-radius: 10px 10px 0 0;
}
.callflows-port #directory-form #basic .add_user select {
	width: 180px;
}
.callflows-port #directory-form #basic .add_user .add_user_fields {
	margin: auto;
	width: 200px;
}
.callflows-port #directory-form #basic .add_user .add_user_fields .tooltip-wrapper {
	margin-left: 0px;
}
.callflows-port #directory-form #basic .add_user .add_user_fields ul {
	list-style-type: none;
}
.callflows-port #directory-form #basic .add_user .add_user_div {
	margin: 10px auto auto auto;
	width: 200px;
	padding-bottom: 15px;
}
.callflows-port #directory-form #basic .add_user .add_user_div a {
	color: #333333;
}
.callflows-port #directory-form #basic .add_user label {
	color: #404040;
	width: auto;
}
.callflows-port #directory-form #basic .add_user .add_user_div:hover a {
	color: #3E7A8C;
}
.callflows-port #directory-form #basic .add_user .add_user_div:hover .add_user_icon {
	background-position: 0 -24px;
	cursor: pointer;
}
.callflows-port #timeofday-form {
	color: #EBEBEB;
}
.callflows-port #timeofday-form .time_wrapper_field {
	height: 50px;
	padding: 10px 20px 0 0;
}
.callflows-port #timeofday-form #days_checkboxes .fake_checkbox {
	float: left;
	color: #eeeeee;
	width: 15px;
	height: 20px;
	line-height: 20px;
	text-align: center;
	padding: 0px;
	margin: 0px;
	border-top: 1px solid #000000;
	border-bottom: 1px solid #000000;
	border-right: 1px solid #000000;
	background-color: #989898;
	cursor: pointer;
}
.callflows-port #timeofday-form #days_checkboxes .fake_checkbox:first-child {
	border-left: 1px solid #000000;
	border-radius: 5px 0 0 5px;
}
.callflows-port #timeofday-form #days_checkboxes .fake_checkbox:last-child {
	border-radius: 0 5px 5px 0;
}
.callflows-port #timeofday-form #days_checkboxes .fake_checkbox:hover {
	background-color: #BEBEBE;
}
.callflows-port #timeofday-form #days_checkboxes .fake_checkbox.checked {
	background-color: #3E7A8C;
}
.callflows-port #timeofday-form .jslider .jslider-label {
	display: none;
}
.callflows-port#ring_group_popup .form_content .popup_field .media_action {
	color: #3E7A8C;
	margin-left: 10px;
}
.callflows-port#ring_group_popup #two_columns .wrapper {
	width: 700px;
}
.callflows-port#ring_group_popup #two_columns .sortable_li a.drag_btn {
	margin-right: 0px;
}
.callflows-port#ring_group_popup #two_columns .sortable_li .icon {
	float: left;
	margin-top: 3px;
}
.callflows-port#ring_group_popup #two_columns .sortable_li .icon.head1 {
	background-position: -477px -197px;
}
.callflows-port#ring_group_popup #two_columns .sortable_li .icon.device {
	background-position: -508px -166px;
}
.callflows-port#ring_group_popup #two_columns .sortable_li .icon.trash {
	background-position: -32px -68px;
	margin-left: 10px;
}
.callflows-port#ring_group_popup #two_columns .column.left {
	border-radius: 0px 0px 5px 5px;
	padding: 0px 0px 5px;
}
.callflows-port#ring_group_popup #two_columns .column.left .search_box {
	background: #AFAFAF;
	height: 27px;
}
.callflows-port#ring_group_popup #two_columns .column.left .search_box .searchsubmit1 {
	margin-left: 18px;
}
.callflows-port#ring_group_popup #two_columns .column.right {
	width: 420px;
}
.callflows-port#ring_group_popup.page_group #two_columns .column.right .item_name {
	width: 315px;
}
.callflows-port#ring_group_popup #two_columns .column.right .item_name {
	width: 205px;
	padding-left: 6px;
}
.callflows-port#ring_group_popup #two_columns .actions_item {
	font-size: 10px;
	width: 39px;
	float: left;
	line-height: 28px;
	height: 28px;
	border-left: 1px solid #444444;
}
.callflows-port#ring_group_popup #two_columns .options {
	font-size: 10px;
	width: 110px;
	line-height: 28px;
	height: 28px;
	float: left;
}
.callflows-port#ring_group_popup #two_columns .options .option {
	height: 12px;
	margin: 2px 5px 0;
}
.callflows-port#ring_group_popup #two_columns .column.right ul.connect {
	width: 420px;
}
.callflows-port#ring_group_popup #two_columns .column.right .title_column .title{
	float: left;
	width: 243px;
	height: 28px;
	line-height: 28px;
}
.callflows-port#ring_group_popup.page_group #two_columns .column.right .title_column .title{
	width: 353px;
}
.callflows-port#ring_group_popup .form_content .popup_field input {
	margin: 0px;
}
.callflows-port#ring_group_popup .form_content .popup_field select {
	margin: 0px;
	width: auto;
}
.callflows-port#ring_group_popup .form_content .popup_field {
	text-align: left;
}
.callflows-port#ring_group_popup #two_columns .wrapper .settings_tabs {
	margin: 0px;
}
.callflows-port#ring_group_popup #two_columns .wrapper .settings_tabs > li {
	width: 71px;
	height: 22px;
	line-height: 22px;
	border: 1px solid #888;
	float: left;
	border-radius: 0px;
	color: #fff;
	background: #b2b2b2; 
	background: -moz-linear-gradient(top, #b2b2b2 1%, #7c7c7c 50%, #333333 100%); 
	background: -webkit-gradient(linear, left top, left bottom, color-stop(1%,#b2b2b2), color-stop(50%,#7c7c7c), color-stop(100%,#333333)); 
	background: -webkit-linear-gradient(top, #b2b2b2 1%,#7c7c7c 50%,#333333 100%); 
	background: -o-linear-gradient(top, #b2b2b2 1%,#7c7c7c 50%,#333333 100%); 
	background: -ms-linear-gradient(top, #b2b2b2 1%,#7c7c7c 50%,#333333 100%); 
	background: linear-gradient(top, #b2b2b2 1%,#7c7c7c 50%,#333333 100%); 
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#b2b2b2', endColorstr='#333333',GradientType=0 ); 
}
.callflows-port#ring_group_popup #two_columns .wrapper .settings_tabs > li:first-child {
	border-radius: 5px 0px 0px 0px;
}
.callflows-port#ring_group_popup #two_columns .wrapper .settings_tabs > li:last-of-type {
	border-radius: 0px 5px 0px 0px;
	width: 72px;
}
.callflows-port#ring_group_popup #two_columns .wrapper .settings_tabs > li.current{
	background: #3E7A8C; 
	background: -moz-linear-gradient(top, #3E7A8C 0%, #2989d8 50%, #203838 100%); 
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#3E7A8C), color-stop(50%,#2989d8), color-stop(100%,#203838)); 
	background: -webkit-linear-gradient(top, #3E7A8C 0%,#2989d8 50%,#203838 100%); 
	background: -o-linear-gradient(top, #3E7A8C 0%,#2989d8 50%,#203838 100%); 
	background: -ms-linear-gradient(top, #3E7A8C 0%,#2989d8 50%,#203838 100%); 
	background: linear-gradient(top, #3E7A8C 0%,#2989d8 50%,#203838 100%); 
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3E7A8C', endColorstr='#203838',GradientType=0 ); 
}
.callflows-port#ring_group_popup #two_columns .wrapper .settings_tabs > li > a{
	outline: none;
	text-decoration: none;
	color: #fff;
	display: block;
	height: 22px;
}
#ws_callflow > .callflow {
	float: left;
	width: 85%;
}
#ws_callflow .callflow .root {
	width: 322px;
}
#ws_callflow .callflow .root > .top_bar {
        background-color: {{ m.config.mod_kazoo.color1.value }};
        text-align: left;
}
#ws_callflow .callflow .root > .top_bar > span {
	line-height: 25px;
}
#ws_callflow .callflow .root > .top_bar .name {
	float: left;
	margin-left: 10px;
	font-weight: bold;
	cursor: default;
}
#ws_callflow .callflow .root > .top_bar .add_number {
	float: right;
}
#ws_callflow .callflow .root > .content .number_row {
	background-image: url(/lib/images/callflow/nav_line_horizontal.jpg);
	background-position: bottom;
	background-repeat: repeat-x;
	height: 32px;
	background-color: #424242;
}
#ws_callflow .callflow .root > .content .number_row:last-child {
	background: none;
	background-color: #424242;
	height: 30px;
	border-radius: 0px 0px 2px 2px;
}
#ws_callflow .callflow .root > .content .number_column {
	float: left;
	height: 30px;
	line-height: 30px;
	font-size: 11px;
	text-indent: 15px;
	text-align: left;
	position: relative;
}
#ws_callflow .callflow .root > .content .number_column.full {
	width: 312px;
	text-align: center;
}
#ws_callflow .callflow .root > .content .number_column.second {
	width: 163px;
	background-image: url(/lib/images/callflow/nav_line.jpg);
	background-position: left;
	background-repeat: repeat-y;
}
#ws_callflow .callflow .root > .content .number_column.first {
	width: 159px;
}
#ws_callflow .callflow .root > .content .number_column.empty {
	cursor: default;
}
#ws_callflow .callflow .root > .content .number_column .delete {
	background-image: url(/lib/images/callflow/btn_delete.png);
	background-repeat: no-repeat;
	background-position: center;
	width: 6px;
	height: 6px;
	display: inline-block;
	position: absolute;
	padding: 5px;
	right: 0px;
	top: 0px;
	cursor: pointer;
}
#ws_callflow .callflow .root > .content .number_column .delete:hover {
	background-image: url(/lib/images/callflow/btn_delete_blue.png);
}
#ws_callflow .callflow .node {
	display: inline-block;
	cursor: -moz-grab;
	cursor: -webkit-grab;
	cursor: grab;
}
#ws_callflow .callflow .node[name="root"] {
	cursor: default;
}
#ws_callflow .callflow .node .node-options .delete {
	background-image: url(/lib/images/callflow/btn_delete.png);
	background-repeat: no-repeat;
	background-position: center;
	width: 6px;
	height: 6px;
	position: absolute;
	top: 0px;
	right: 0px;
	padding: 5px;
	cursor: pointer;
}
#ws_callflow .callflow .node .node-options .delete:hover {
	background-image: url(/lib/images/callflow/btn_delete_blue.png);
}
#ws_callflow .tool .icon {
	margin: 2px;
	display: inline-block;
}
#ws_callflow .tools .category {
	text-align: center;
	background: url(/lib/images/callflow/background_category.png) no-repeat;
	background-position: top center;
	cursor: default;
}
#ws_callflow .tools .category .content {
	background-color: #777777;
	border: 1px solid #333333;
}
#ws_callflow .tools .open {
	font-size: 12px;
	height: 26px;
	line-height: 26px;
	background-repeat: no-repeat;
	background-position: 5px center;
}
#ws_callflow .tools .active .open {
	background-image: url(/lib/images/callflow/arrow_active.png);
}
#ws_callflow .tools .inactive .open{
	background-image: url(/lib/images/callflow/arrow_inactive.png);
}
#ws_callflow .tools .tool {
	background: #777777;
	float: left;
	width: 82px;
	padding-left: 1px;
	padding-top: 1px;
	cursor: -moz-grab;
	cursor: -webkit-grab;
	cursor: grab;
}
#ws_callflow .destination {
	border-radius: 2px;
	border: 3px solid #3E7A8C;
}
#ws_callflow .tools .tool .action {
	z-index: 19;
	height:56px;
	background: url(/lib/images/callflow/blackbox_small.png) no-repeat;
	min-width: 82px;
}
#ws_callflow .tools .app_list_nav {
	background: #777777;
	padding-top: 1px;
}
#ws_callflow .callflow .icons_black.node {
	width: 143px;
	height: 84px;
	background: url(/lib/images/callflow/blackbox.png) no-repeat;
}
#ws_callflow #ws_cf_flow .children .child:last-child:not(:first-child) {
	padding-right: 10px;
}
#ws_callflow #ws_cf_flow .children .child:first-child:not(:last-child) {
	padding-left: 10px;
}
#ws_callflow .children > .child > .div_line {
	display: inline-block;
	height: 6px;
	width: 100%;
	background-image: url(/lib/images/callflow/line_callflow.png);
	background-repeat: repeat-x;
	margin-top: -37px;
	margin-right: 0px;
	margin-left: 0px;
	padding: 0px;
	float: left;
}
#ws_callflow .children > .child:first-child > .div_line {
	width: 50%;
	float: right;
}
#ws_callflow .children > .child:last-child > .div_line {
	width: 50%;
	float: left;
}
#ws_callflow .children > .child:first-child:last-child > .div_line {
	display: none;
}
#ws_callflow .children > .child > .span_arrow {
	display: inline-block;
	width: 145px;
	background-repeat: no-repeat;
	background-position: center center;
	margin: 2px 0px 2px;
	padding: 0px;
	position: relative;
}
#ws_callflow .children > .child > .span_arrow.small {
	height: 31px;
	background-image: url(/lib/images/callflow/center_arrow.png);
}
#ws_callflow .children > .child:first-child > .span_arrow.small {
	background-image: url(/lib/images/callflow/left_arrow.png);
}
#ws_callflow .children > .child:last-child > .span_arrow.small {
	background-image: url(/lib/images/callflow/right_arrow.png);
}
#ws_callflow .children > .child:first-child:last-child > .span_arrow.small {
	background-image: url(/lib/images/callflow/small_arrow.png);
}
#ws_callflow .children > .child > .span_arrow.large {
	float: none;
	height: 48px;
	background-image: url(/lib/images/callflow/tall_arrow.png);
}
#ws_callflow .a_link_option {
	color: #EEE;
	font-size: 12px;
}
#ws_callflow .div_option {
	display: inline-block;
	height: 15px;
	line-height: 15px;
	width: 131px;
	background-color: #474747;
	margin: 0;
	padding: 0;
	border: 1px solid #303030;
	border-radius: 2px;
}
#ws_callflow .div_icon {
	height: 50px;
}
#ws_callflow .div_icon > span {
	display: inline-block;
	max-width: 100px;
	vertical-align: middle;
}
#ws_callflow .module {
	font-size: 13px;
	height: 59px;
	margin-top: 25px;
	cursor: default;
}
#ws_callflow .div_icon .module_name {
	text-transform: uppercase;
	text-align: center;
}
#ws_callflow .details {
	font-size: 10px;
	margin-top: -10px;
	overflow: hidden;
}
.dialog_popup_new {
	padding: 15px;
}
.dialog_popup_new .popup_field {
	height: 40px;
	line-height: 40px;
	margin-bottom: 10px;
}
.dialog_popup_new .popup_field > * {
	margin-right: 10px;
}
.dialog_popup_new .buttons {
	text-align: center;
}
.dialog_popup_new form {
	margin: 0;
}
.dialog_popup_new.edit_name {
	width: 350px;
}
.dialog_popup_new.edit_name .fancy_help_text {
	font-size: 12px;
	margin-bottom: 10px;
}
.dialog_popup_new.edit_name input[type="checkbox"] {
	margin: 0;
}
.dialog_popup_new.add_number_popup {
	width: 475px;
}
.add_number_popup .popup_field label {
	width: 110px;
}
.add_number_popup input[type=radio] {
	margin: -5px 5px 0 10px;
}
.add_number_popup #list_numbers {
	width: 157px;
}
.add_number_popup #add_number_text {
	width: 172px;
}
.add_number_popup .extensions_content, 
.add_number_popup .list_numbers_content {
	display: inline-block;
}
.add_number_popup .list_numbers_content .nav {
	margin-top: 7px;
}
.fax_callflow_popup .checkbox_field,
.fax_callflow_popup .checkbox_field label {
	padding: 0px;
}
.fax_callflow_popup .checkbox_field #t_38_checkbox {
	float: left;
}
#callflow-content .ui-draggable-dragging {
	cursor: -moz-grabbing !important;
	cursor: -webkit-grabbing !important;
	cursor: grabbing !important;
}
#ws_callflow .root .top_bar .edit_icon {
	background: url('/lib/images/callflow/edit_icon.png') no-repeat scroll center center transparent;
	cursor: pointer;
	display: inline-block;
	height: 18px;
	margin: 3px 0px 0px 7px;
	width: 20px;
}
#callflow_container .callflow-help, .popup_help .callflow-help {
	background: url(/lib/images/callflow/callflow_help.gif) no-repeat center;
	height: 644px;
	width: 847px;
	margin: 20px auto auto;
	border-radius: 10px;
}
#callflow_container .callflow-content.edition-mode .callflow-help {
	display: none;
}
#callflow_container .callflow-content.listing-mode #ws_callflow {
	display: none;
}
#ws_callflow {
	width: 100%;
}
#ws_callflow #smartpbx_warning {
	color: red;
	display: none;
	font-style: italic;
	font-weight: lighter;
	margin: auto auto 15px;
	text-align: center;
	width: 50%;
}
#ws_callflow #callflow_header {
	height: 30px;
	margin-top: 15px;
	width: 100%;
}
#ws_callflow #callflow_header #pending_change {
	text-align: center;
	display: none;
}
#ws_callflow #callflow_header #pending_change span {
	color: #3E7A8C;
	font-weight: lighter;
	font-style: italic;
}
#ws_callflow #ws_cf_flow {
        font-size: 12px;
	width: 100%;
	overflow-x: auto;
	padding-top: 10px;
	text-align: center;
}
#ws_callflow span.flow {
	width: 80%;
}
#ws_callflow .child {
	display: inline-block;
	vertical-align: top;
	text-align: center;
	white-space: normal;
}
#ws_callflow .branch {
	display: block;
	text-align: center;
}
#ws_callflow .node.active {
	background-color: #fff;
	border-radius: 2px;
	border: 3px solid #3E7A8C;
}
#ws_callflow .node.inactive {
	filter:alpha(opacity=50);
	-moz-opacity:0.5;
	-khtml-opacity: 0.5;
	opacity: 0.5;
}
#ws_callflow .children {
	display: block;
}
#ws_callflow .flowchart {
	margin-right: 180px;
	overflow: auto;
}
#ws_callflow .tools {
	float: right;
}
#ws_callflow .tools #ws_cf_tools {
	padding-top: 10px;
	padding-bottom:30px;
	width: 168px;
}
#ws_callflow .tool {
	text-align: center;
	vertical-align: middle;
}
#ws_callflow .tool_name {
	font-size: 11px;
	line-height: 11px;
}
#ws_callflow .tools .category.inactive .content {
	display: none;
}
#ws_callflow .tool .action.inactive {
	display: none;
}
#ws_callflow .tool .action.active {
	z-index: 10000;
}
#ws_callflow .title {
	background: #3E7A8C;
	font-size: 12px;
	height: 25px;
	line-height: 25px;
	border-radius: 2px 2px 0px 0px;
	text-align: center;
	color: #fff;
	font-weight: bold;
}
#callflow_container .wrapper_callflow_buttons {
	display: block;
	width: 236px;
	margin: auto;
	margin-bottom: 5px;
}
#callflow_container .wrapper_callflow_buttons .monster-button {
	width: 114px;
	text-align: center;
	display: inline-block;
	margin-left: 0px;
}
#callflow_container .wrapper_callflow_buttons .monster-button:first-child {
	margin-right: 10px;
}
#callflow_container .callflow_helpbox_wrapper {
	position: absolute;
	right: 175px;
	width: 160px;
	top: 100px;
	display: none;
}
#callflow_container .callflow_helpbox_wrapper .tip_box {
	background-color: #3D3D3D;
	border: 1px solid #333333;
	border-radius: 2px;
	opacity: 80%;
	padding: 5px 2px 5px 9px;
	text-align: left;
	font-size: 10px;
	line-height: 12px;
}
#callflow_container .tooltip {
	float: right;
	margin-top: 6px;
	cursor: pointer;
}
#callflow_container .pulse-box {
	-webkit-animation: "pulse-box" 1s ease-in-out 0 infinite alternate;
	animation-name: pulse-box;
	animation-duration: 1s;
	animation-timing-function: ease-in-out;
	animation-delay: 0;
	animation-iteration-count: infinite;
	animation-direction: alternate;
}
@-webkit-keyframes pulse-box {
	0% { box-shadow: 0px 0px 0px #73F03C inset, 0px 0px 0px #14FF00; }
	100% { box-shadow: 0px 0px 30px #73F03C inset, 0px 0px 10px #14FF00; }
}
@keyframes pulse-box {
	0% { box-shadow: 0px 0px 0px #73F03C inset, 0px 0px 0px #14FF00; }
	100% { box-shadow: 0px 0px 30px #73F03C inset, 0px 0px 10px #14FF00; }
}
#callflow_container {
	color: #ebebeb;
	min-height: 100%;
}
#callflow_container .callflow-content {
	margin-left: 240px;
	background-color: #fff;
	overflow-y: auto;
}
#callflow_container .left-bar-container {
	float: left;
	background-color: #F3F3F3;
	border-right: solid 1px #999;
	width: 240px;
	overflow: hidden;
	border-radius: inherit;
}
#callflow_container .left-bar-container .search-box {
	width: 220px;
	padding: 20px 10px;
	border-bottom: solid 1px #999;
}
#callflow_container .left-bar-container .search-box .search-query {
	width: 178px;
}
#callflow_container .left-bar-container.ab-dropdown .list-container {
	max-height: 300px;
}
#callflow_container .left-bar-container .list {
	margin: 0;
	list-style: none;
	float: left;
	overflow-y: auto;
	overflow-x: hidden;
	width: 240px;
	height: 100%;
	max-height: inherit;
}
#callflow_container .left-bar-container .list-add {
	line-height: 50px;
	max-height: 50px;
	font-weight: 600;
	background-color: #ddd;
	width: 240px;
	background-image: -webkit-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 80%) 100%);
	background-image:    -moz-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 80%) 100%);
	background-image:     -ms-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 80%) 100%);
	background-image:      -o-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 80%) 100%);
	background-image:         linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 80%) 100%);
	color: #555;
}
#callflow_container .left-bar-container .list-add i {
	margin: 10px;
}
#callflow_container .left-bar-container .list-add:hover {
	background: #ccc;
	
	cursor: pointer;
}
#callflow_container .left-bar-container .list-add:hover i {
	
}
#callflow_container .left-bar-container .list-loader {
	padding: 10px;
	border-bottom: solid 1px #ccc;
}
#callflow_container .left-bar-container .list-element {
	line-height: 60px;
	max-height: 60px;
	overflow: hidden;
	border-bottom: solid 1px #ccc;
}
#callflow_container .left-bar-container .list-element > div {
	background-color: #f6f6f6;
	background-image: -webkit-linear-gradient(top, hsl(0, 0%, 98%) 0%, hsl(0, 0%, 95%) 100%);
	background-image:    -moz-linear-gradient(top, hsl(0, 0%, 98%) 0%, hsl(0, 0%, 95%) 100%);
	background-image:     -ms-linear-gradient(top, hsl(0, 0%, 98%) 0%, hsl(0, 0%, 95%) 100%);
	background-image:      -o-linear-gradient(top, hsl(0, 0%, 98%) 0%, hsl(0, 0%, 95%) 100%);
	background-image:         linear-gradient(top, hsl(0, 0%, 98%) 0%, hsl(0, 0%, 95%) 100%);
	color: #555;
	padding-left: 10px;
}
#callflow_container .left-bar-container .list-element > div:hover {
	background: #eee;
	cursor: pointer;
	
}
#callflow_container .left-bar-container .search-link {
	border-bottom: solid 1px #ccc;
	text-align: center;
	font-size: 12px;
	line-height: 15px;
	padding: 5px;
	color: #555;
	background-color: #f6f6f6;
	background-image: -webkit-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 85%) 100%);
	background-image:    -moz-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 85%) 100%);
	background-image:     -ms-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 85%) 100%);
	background-image:      -o-linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 85%) 100%);
	background-image:         linear-gradient(top, hsl(0, 0%, 90%) 0%, hsl(0, 0%, 85%) 100%);
}
#callflow_container .left-bar-container .search-link:hover {
	background: #eee;
	cursor: pointer;
}
#callflow_container .left-bar-container .search-link .search-value {
	font-weight: 600;
	text-shadow: 1px 1px 0px #ccc;
}
#callflow_container .left-bar-container .search-link .search-reset {
	color: #22a5ff;
	line-height: 30px;
	font-weight: 600;
}
#callflow_container .left-bar-container .search-link:not(.active) .search-reset {
	display: none;
}
#callflow_container .left-bar-container .search-link.active > *:not(.search-reset) {
	display: none;
}
#callflow_container .list-container .link .title {
	font-size: 16px;
	height: 40px;
	line-height: 40px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
#callflow_container .list-container .link .title.standalone {
	height: 60px;
	line-height: 60px;
}
#callflow_container .list-container .link .description {
	font-size: 10px;
	height: 20px;
	line-height: 10px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.dialog_popup {
	padding: 10px 20px;
	text-align: center;
}
.dialog_popup h1 {
	padding: 0 0 10px 0;
	text-shadow: none;
	font-size: 24px;
	font-weight: bold;
	color: #29ABE1;
}
.dialog_popup .btn_wrapper_popup {
	float: left;
	width: 100%;
	padding: 30px 0px 10px 0px;
}
.dialog_popup .form_content {
	display: inline-block;
}
.dialog_popup .form_content label {
	font-weight: bold;
	width: auto;
	margin-right: 10px;
	color: #333;
	float: left;
	padding-top: 5px;
}
.dialog_popup .form_content select {
	width: 100%;
	max-width: 200px;
}
.dialog_popup .form_content .select_wrapper {
	float: left;
}
.dialog_popup .form_content .select_wrapper .action_links_div a {
	float: right;
	width: 100%;
	text-align: right;
	text-decoration: underline;
	color: #3E7A8C;
	margin-top: 3px;
}
.dialog_popup .form_content .popup_field {
	padding-bottom: 15px;
}
.dialog_popup .parameter_div {
	padding: 10px 0px 10px 0px;
	width: auto;
	max-width: 300px;
	margin: auto;
	display: block;
}
.parameter_description {
	font-size: 10px;
	border-radius: 2px;
}
.dialog_popup input.size2 {
	width: 20px;
}
.inline_popup {
	padding: 0 20px;
}
.inline_popup.small .main_content {
	width: 450px;
}
.inline_popup.small .main_content .pill-content .clearfix {
	display: block;
}
.dialog_popup .fancy_help_text {
	font-size: 12px;
}
.callflows-port .reset_all {
	margin:0;
	padding:0;
	border:0;
	font-weight:normal;
	font-style:normal;
	font-size:100%;
	line-height:1;
	font-family:inherit;
}
.callflows-port .reset_margin {
	margin:0;
}
.callflows-port .reset_padding {
	padding:0;
}
.callflows-port .reset_border {
	border:0;
	background-color:none;
}
.callflows-port .gradient_strong {
	background:#434343;
	background:-moz-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0%, #434343), color-stop(50%, #353535), color-stop(100%, #282828));
	background:-webkit-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-o-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-ms-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	filter:progid:dximagetransform.microsoft.gradient(startColorstr='#434343', endColorstr='#282828', GradientType=0);
}
.callflows-port .gradient_light {
	background:#373737;
	background:-moz-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0%, #373737), color-stop(50%, #2e2e2e), color-stop(100%, #2f2f2f));
	background:-webkit-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:-o-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:-ms-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	filter:progid:dximagetransform.microsoft.gradient(startColorstr='#373737', endColorstr='#2f2f2f', GradientType=0);
}
.modal-dialog h1,
.modal-dialog h2,
.modal-dialog h3,
.modal-dialog h4,
.modal-dialog h5 {
	color:#3E7A8C;
	font-weight:lighter;
}
.callflows-port h3 {
	font-size:14px;
}
.callflows-port h1 {
	font-size:24px;
	letter-spacing: 1px;
	margin-top: 0;
}
.callflows-port hr {
	margin:0;
	border-top:1px solid #404040;
	border-bottom:1px solid #202020;
}
.callflows-port .monster-button {
	min-width:100px;
}
.callflows-port input[type="file"] {
	background-color:transparent;
	padding-top:5px;
}
.callflows-port input {
	color:#555;
}
.callflows-port ul, ol {
	list-style: none;
	margin: 0;
}
.callflows-port form .clearfix:last-child {
	margin-bottom:0;
}
.callflows-port .toggled {
	margin-bottom:30px;
	margin-top:30px;
}
.callflows-port .whapp-header>h1, .whapp-header>h2, .whapp-header>h3 {
	float:left;
}
.callflows-port .whapp-header>.buttons-right {
	margin-top:10px;
}
.callflows-port .input-append>span.add-on {
	-webkit-border-top-left-radius:2px;
	-webkit-border-top-right-radius:0;
	-webkit-border-bottom-right-radius:0;
	-webkit-border-bottom-left-radius:2px;
	-moz-border-radius-topleft:2px;
	-moz-border-radius-topright:0;
	-moz-border-radius-bottomright:0;
	-moz-border-radius-bottomleft:2px;
	border-top-left-radius:2px;
	border-top-right-radius:0;
	border-bottom-right-radius:0;
	border-bottom-left-radius:2px;
	margin:0;
	margin-right:-1px;
	font-size:16px;
	font-weight:bold;
}
.callflows-port .input-append>input {
	-webkit-border-top-left-radius:0;
	-webkit-border-top-right-radius:0;
	-webkit-border-bottom-right-radius:0;
	-webkit-border-bottom-left-radius:0;
	-moz-border-radius-topleft:0;
	-moz-border-radius-topright:0;
	-moz-border-radius-bottomright:0;
	-moz-border-radius-bottomleft:0;
	border-top-left-radius:0;
	border-top-right-radius:0;
	border-bottom-right-radius:0;
	border-bottom-left-radius:0;
}
.callflows-port .pill-content {
	background:#373737;
	background:-moz-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0%, #373737), color-stop(50%, #2e2e2e), color-stop(100%, #2f2f2f));
	background:-webkit-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:-o-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:-ms-linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	background:linear-gradient(top, #373737 0, #2e2e2e 50%, #2f2f2f 100%);
	filter:progid:dximagetransform.microsoft.gradient(startColorstr='#373737', endColorstr='#2f2f2f', GradientType=0);
	color: #EEE;
	padding:30px;
	border:1px solid #3E7A8C;
	box-shadow:1px 2px 5px 0px #363636;
	-moz-box-shadow:4px 5px 10px 1px #262626;
	-webkit-box-shadow:4px 5px 10px 1px #262626;
}
.callflows-port .pill-content h3, 
.callflows-port .row h3 {
	margin-bottom:20px;
	color:#0ac9ff;
}
.callflows-port .pill-content .edit_create {
	margin-left:20px;
	display:inline;
}
.callflows-port .pill-content .edit_create a {
	color: #EEE;
}
.callflows-port .pill-content .edit_create > a:not(:first-child) {
	margin-left:5px;
}
.callflows-port .btn.black:first-child {
	border-radius: 2px 0 0 2px;
}
.callflows-port .btn.black:last-child {
	border-radius: 0 2px 2px 0;
}
.callflows-port .btn.black {
	background:#434343;
	background:-moz-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0%, #434343), color-stop(50%, #353535), color-stop(100%, #282828));
	background:-webkit-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-o-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-ms-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	filter:progid:dximagetransform.microsoft.gradient(startColorstr='#434343', endColorstr='#282828', GradientType=0);
	color:#e6e6e6;
	text-shadow:none;
	font-size:12px;
	border:1px solid #1a1a1a;
	border-radius: 0;
}
.callflows-port .btn.black.activate {
	box-shadow:inset 0 0 10px 1px #000;
	-moz-box-shadow:inset 0 0 10px 1px #000;
	-webkit-box-shadow:inset 0 0 10px 1px #000;
}
.callflows-port .btn.black:hover {
	color:#e6e6e6;
	background:#434343;
	background:-moz-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0%, #434343), color-stop(50%, #353535), color-stop(100%, #282828));
	background:-webkit-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-o-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-ms-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	filter:progid:dximagetransform.microsoft.gradient(startColorstr='#434343', endColorstr='#282828', GradientType=0);
	box-shadow:inset 0 0 10px 1px #000;
	-moz-box-shadow:inset 0 0 10px 1px #000;
	-webkit-box-shadow:inset 0 0 10px 1px #000;
}
.callflows-port .buttons-right {
	text-align: right;
}
.callflows-port .buttons-right>.monster-button:not(:last-child) {
	margin-right:6px;
}
.callflows-port .pasted>.monster-button:first-child {
	-webkit-border-top-left-radius:2px;
	-webkit-border-top-right-radius:0;
	-webkit-border-bottom-right-radius:0;
	-webkit-border-bottom-left-radius:2px;
	-moz-border-radius-topleft:2px;
	-moz-border-radius-topright:0;
	-moz-border-radius-bottomright:0;
	-moz-border-radius-bottomleft:2px;
	border-top-left-radius:2px;
	border-top-right-radius:0;
	border-bottom-right-radius:0;
	border-bottom-left-radius:2px;
	margin-right:-4px;
}
.callflows-port .pasted>.monster-button:last-child {
	-webkit-border-top-left-radius:0;
	-webkit-border-top-right-radius:2px;
	-webkit-border-bottom-right-radius:2px;
	-webkit-border-bottom-left-radius:0;
	-moz-border-radius-topleft:0;
	-moz-border-radius-topright:2px;
	-moz-border-radius-bottomright:2px;
	-moz-border-radius-bottomleft:0;
	border-top-left-radius:0;
	border-top-right-radius:2px;
	border-bottom-right-radius:2px;
	border-bottom-left-radius:0;
}
.callflows-port .main_content {
	margin: 0 auto;
	padding: 10px 0 15px 0;
	width: 800px;
}
.callflows-port input[type="checkbox"] {
	margin: 0 5px 0 0;
}
.dialog_popup.callflows-port form label:not(.monster-invalid) {
	color: #333;
}
.callflows-port form label:not(.monster-invalid) {
	float: left;
	font-size: 13px;
	line-height: 18px;
	padding-top: 6px;
	text-align: right;
	width: 130px;
	color:#e6e6e6;
}
.callflows-port label.monster-invalid {
	position: relative;
	color: orange;
	margin-top: -10px;
}
.callflows-port form .input {
	margin-left: 150px;
}
.callflows-port form .clearfix {
	margin-bottom: 10px;
}
.callflows-port form .inputs-list label {
	display: block;
	float: none;
	line-height: 18px;
	margin-left: 20px;
	padding: 0;
	text-align: left;
	white-space: normal;
	width: auto;
}
.callflows-port form .inputs-list input[type="radio"],
.callflows-port form .inputs-list input[type="checkbox"] {
	float: left;
	margin-bottom: 0;
	margin-left: -20px;
}
.callflows-port form input.span4, 
.callflows-port form textarea.span4 {
	display: inline-block;
	float: none;
	margin-left: 0;
	width: 210px;
}
.callflows-port li {
	color: #808080;
	line-height: 18px;
}
.callflows-port .tab-content > .tab-pane,
.callflows-port .pill-content > .pill-pane,
.callflows-port .tab-content > div, 
.callflows-port .pill-content > div {
	display: none;
}
.callflows-port .tab-content > .active,
.callflows-port .pill-content > .active {
	display: block;
}
.callflows-port .tabs:before, 
.callflows-port .pills:before, 
..callflows-port tabs:after, 
.callflows-port .pills:after {
	content: "";
	display: table;
}
.callflows-port .tabs:after, 
.callflows-port .pills:after {
	clear: both;
}
.callflows-port .tabs:before,
.callflows-port .pills:before,
.callflows-port .tabs:after,
.callflows-port .pills:after {
	content: "";
	display: table;
}
.callflows-port .pills {
	list-style: outside none none;
	margin: 0 0 18px;
	padding: 0;
}
.callflows-port .pills > li {
	float: left;
}
.callflows-port .pills > li > a {
	display: block;
}
.callflows-port .tabs {
	list-style: none;
	padding: 0;
	background-color:none;
}
.callflows-port .tabs > li {
	background:#434343;
	background:-moz-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0%, #434343), color-stop(50%, #353535), color-stop(100%, #282828));
	background:-webkit-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-o-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:-ms-linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	background:linear-gradient(top, #434343 0, #353535 50%, #282828 100%);
	filter:progid:dximagetransform.microsoft.gradient(startColorstr='#434343', endColorstr='#282828', GradientType=0);
	border-top:1px solid;
	border-top-color:#262626;
	border-left:1px solid;
	border-left-color:#2f2f2f;
	float: left;
	font-size: 12px;
	margin-bottom: -1px;
	position: relative;
}
.callflows-port .tabs > li:first-child {
	border-radius: 2px 0 0 0;
	border-left: 1px solid;
	border-left-color:#1a1a1a;
}
.callflows-port .tabs > li:last-child {
	border-radius: 0 2px 0 0;
	border-right: 1px solid;
	border-right-color: #1a1a1a;
}
.callflows-port .tabs > li > a {
	border-radius: 2px 2px 0 0;
	display: block;
	line-height: 34px;
	padding: 0 15px;
	color: #fff;
}
.callflows-port .tabs > li > a:hover {
	text-decoration: none;
}
.callflows-port .tabs .active {
	border-top:0;
	border-bottom:1px solid #373737;
}
.callflows-port .tabs > li:first-child.active {
	border-left:1px solid #3E7A8C;
}
.callflows-port .tabs > li:last-child.active {
	border-right:0;
}
.callflows-port .tabs > li > a > .icon {
	margin-right:3px;
}
.callflows-port .tabs > li > a:hover {
	color:#fff;
	background-color:transparent;
}
.callflows-port .tabs .active > a, 
.callflows-port .tabs .active > a:hover {
	border:0;
	background-color:none;
	border-radius: 2px 2px 0 0;
	color:#fff;
	background:#373737;
	border-top:1px solid;
	border-top-color:#3E7A8C;
	border-left:1px solid;
	border-left-color:#3E7A8C;
	border-right:1px solid;
	border-right-color:#3E7A8C;
	font-weight:bold;
	text-decoration: none;
}
.callflows-port .tabs li:first-child.active > a {
	border-left : none;
}
.callflows-port .popover-content {
	color: #333;
}
.callflows-port .help_box {
	margin-bottom: 10px;
	padding: 10px;
	padding-bottom: 10px;
	border: 1px solid #363636;
	border-radius: 2px 2px 2px 2px;
	background: #3E7A8C;
	background: -webkit-gradient(linear, left top, left bottom, from(#3E7A8C), to(#036884)) !important;
	background: -moz-linear-gradient(top,  #3E7A8C,  #036884) !important;
	box-shadow: 1px 1px 1px #333333;
	text-align: center;
	font-style: italic;
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#3E7A8C', endColorstr='#036884') !important;
}
.callflows-port#ring_group_popup #two_columns .column.right ul.connect.no_element {
	background: url(/lib/images/callflow/empty_ring_group.png) no-repeat center;
}
.callflows-port #two_columns .wrapper li a.drag_btn {
	background-image: url(/lib/images/callflow/drag_btn_28.png);
}
.callflows-port .search_box .searchsubmit1 {
	background: url(/lib/images/callflow/search_left.png) no-repeat top left;
}
.callflows-port .search_box .searchsubmit2 {
	background: url(/lib/images/callflow/search_right.png) no-repeat top right;
}
.callflows-port .search_box .searchfield {
	background: url(/lib/images/callflow/search_mid.png) repeat-x;
}
#callflow_container .entity-manager {
	padding: 10px;
	max-width: 1120px;
	margin: auto;
	color: #303039;
}
#callflow_container .entity-manager .grid-header {
	font-size: 34px;
	line-height: 40px;
	margin: 20px 10px;
}
#callflow_container .entity-manager .entity-element {
	display: inline-block;
	margin: 10px;
	text-align: center;
	width: 140px;
	height: 140px;
	padding: 0px;
	font-size: 20px;
	cursor: pointer;
	border: solid 1px #303039;
	box-sizing: border-box;
	border-radius: 2px;
}
#callflow_container .entity-manager .entity-element.callflow-element {
	width: 300px;
	height: 300px;
	float: left;
	font-size: 50px;
	font-weight: 300;
}
#callflow_container .entity-manager .entity-element:hover {
	background-color: #f0f0f9;
}
#callflow_container .entity-manager .entity-element > div {
	position: relative;
	top: 50%;
	-webkit-transform: translateY(-50%);
	-ms-transform: translateY(-50%);
	transform: translateY(-50%);
}
#callflow_container .entity-edition,
#callflow_container .entity-manager .callflow-edition {
	display: none;
}
#callflow_container .entity-edition .left-bar-container {
	box-sizing: border-box;
}
#callflow_container .entity-edition .callflow-content {
	margin: 0;
	float: left;
	box-sizing: border-box;
	width: 800px; 
	width: -webkit-calc(100% - 240px);
	width: -moz-calc(100% - 240px);
	width: -o-calc(100% - 240px);
	width: calc(100%-240px);
}
#callflow_container .callflow-content .entity-header {
	padding: 18px 40px;
	height: 71px;
	box-sizing: border-box;
	border-bottom: solid 1px #999;
}
#callflow_container .callflow-content .entity-header .entity-title {
	color: #22a5ff;
	font-size: 30px;
	line-height: 36px;
	float:left;
}
#callflow_container .callflow-content .entity-header .back-button {
	float: right;
}
#callflow_container .entity-edition .entity-content {
	padding: 20px 40px;
}

</style>
