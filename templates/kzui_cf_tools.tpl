<div class="tools">
    <div id="ws_cf_tools">
        <div>
            <div class="title">
                Actions
                <div class="tooltip">
                </div>
            </div>
            <div id="Basic" name="Basic" class="category active">
                <div class="open">
                    Basic
                </div>
                <div class="content">
                    {% include "_cf_tool_element.tpl" tool_id="user" tool_name="user" tool_descr="User" icon="user" help="Direct a caller to a specific user" %}
                    {% include "_cf_tool_element.tpl" tool_id="device" tool_name="device" tool_descr="Device" icon="phone" help=_"Ring a VoIP or cell phone or other device" %}
                    {% include "_cf_tool_element.tpl" tool_id="play" tool_name="play" tool_descr="Play Media" icon="play" help="Play an audio file such as a greeting" %}
                    {% include "_cf_tool_element.tpl" tool_id="receive_fax" tool_name="receive_fax" tool_descr="Receive Fax" icon="sip" help="Directs a fax to a specific user" %}
                    {% include "_cf_tool_element.tpl" tool_id="ring_group" tool_name="ring_group" tool_descr="Ring Group" icon="ring_group" 
                                                                                                  help="Ring several VoIP or cell phones in order or at the same time" %}
                    {% include "_cf_tool_element.tpl" tool_id="menu" tool_name="menu" tool_descr="Menu" icon="menu1" help="Ask a caller to push a menu option or dial an extension number" %}
                    {% include "_cf_tool_element.tpl" tool_id="temporal_route" tool_name="temporal_route" tool_descr="Time of Day" icon="temporal_route" help="" %}
                    {% include "_cf_tool_element.tpl" tool_id="branch_recovery" tool_name="branch_recovery" tool_descr="Branch recovery" icon="trash" help="" %}
                    <div class="clear">
                    </div>
                    <div class="app_list_nav">
                    </div>
                </div>
            </div>
            <div id="Advanced" name="Advanced" class="category inactive">
                <div class="open">
                    Advanced
                </div>
                <div class="content">
                    {% include "_cf_tool_element.tpl" tool_id="callflow" tool_name="callflow" tool_descr="Callflow" icon="callflow" help=_"Transfer the call to another call flow" %}
                    {% include "_cf_tool_element.tpl" tool_id="voicemail" tool_name="voicemail" tool_descr="Voicemail" icon="voicemail" help="Direct a caller to leave a voicemail message" %}
                    {% include "_cf_tool_element.tpl" tool_id="cid_check" tool_name="cid_check" tool_descr="CID Check" icon="circle_graph" help="Route incoming call based on Caller ID." %}
                    {% include "_cf_tool_element.tpl" tool_id="prepend_cid" tool_name="prepend_cid" tool_descr="CID Prepend" icon="plus_circle" help="Prepend Caller ID with a text." %}
                    {% include "_cf_tool_element.tpl" tool_id="group_pickup" tool_name="group_pickup" tool_descr="Group Pickup" icon="sip" 
                                                                                                      help="Setup the group pickup feature for a user, device or a group." %}
                    {% include "_cf_tool_element.tpl" tool_id="page_group" tool_name="page_group" tool_descr="Page Group" icon="ring_group" help="Make announcement to the group" %}
                    {% include "_cf_tool_element.tpl" tool_id="conference" tool_name="conference" tool_descr="Conference" icon="conference" help="Connect a caller to a Meet-Me conference bridge" %}
                    {% include "_cf_tool_element.tpl" tool_id="eavesdrop" tool_name="eavesdrop" tool_descr="Eavesdrop" icon="scale1" help="" %}
                    {% include "_cf_tool_element.tpl" tool_id="record_call" tool_name="record_call" tool_descr="Record Call" icon="conference" help="" %}
                    <div class="clear">
                    </div>
                    <div class="app_list_nav">
                    </div>
                </div>
            </div>
            <div id="Time of Day" name="Time of Day" class="category inactive hidden">
                <div class="open">
                    Time of Day
                </div>
                <div class="content">
                    <div class="tool" help="">
                        <div name="temporal_route[]" class="action ui-draggable">
                            <div class="icon medium app_sm temporal_route">
                            </div>
                            <div class="tool_name">
                                Time of Day
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="">
                        <div name="temporal_route[action=disable]" class="action ui-draggable">
                            <div class="icon medium app_sm temporal_route">
                            </div>
                            <div class="tool_name">
                                Disable Time of Day
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="">
                        <div name="temporal_route[action=enable]" class="action ui-draggable">
                            <div class="icon medium app_sm temporal_route">
                            </div>
                            <div class="tool_name">
                                Enable Time of Day
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="">
                        <div name="temporal_route[action=reset]" class="action ui-draggable">
                            <div class="icon medium app_sm temporal_route">
                            </div>
                            <div class="tool_name">
                                Reset Time of Day
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="app_list_nav">
                    </div>
                </div>
            </div>
            <div id="Hotdesking" name="Hotdesking" class="category inactive hidden">
                <div class="open">
                    Hotdesking
                </div>
                <div class="content">
                    <div class="tool" help="Enable Hot desking">
                        <div name="hotdesk[action=login]" class="action ui-draggable">
                            <div class="icon medium app_sm hotdesk_login">
                            </div>
                            <div class="tool_name">
                                Hot Desk login
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="Disable Hot desking">
                        <div name="hotdesk[action=logout]" class="action ui-draggable">
                            <div class="icon medium app_sm hotdesk_logout">
                            </div>
                            <div class="tool_name">
                                Hot Desk logout
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="Toggle Hot desking">
                        <div name="hotdesk[action=toggle]" class="action ui-draggable">
                            <div class="icon medium app_sm hotdesk_toggle">
                            </div>
                            <div class="tool_name">
                                Hot Desk toggle
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="app_list_nav">
                    </div>
                </div>
            </div>
            <div id="Caller-ID" name="Caller-ID" class="category inactive hidden">
                <div class="open">
                    Caller-ID
                </div>
                <div class="content">
                    <div class="tool" help="Set your CallerId by entering it on the phone">
                        <div name="dynamic_cid[]" class="action ui-draggable">
                            <div class="icon medium app_sm rightarrow">
                            </div>
                            <div class="tool_name">
                                Dynamic cid
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="Prepend Caller ID with a text.">
                        <div name="prepend_cid[action=prepend]" class="action ui-draggable">
                            <div class="icon medium app_sm plus_circle">
                            </div>
                            <div class="tool_name">
                                Prepend
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="Reset all the prepended texts before the Caller ID.">
                        <div name="prepend_cid[action=reset]" class="action ui-draggable">
                            <div class="icon medium app_sm loop2">
                            </div>
                            <div class="tool_name">
                                Reset Prepend
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="app_list_nav">
                    </div>
                </div>
            </div>
            <div id="Call Recording" name="Call Recording" class="category inactive hidden">
                <div class="open">
                    Call Recording
                </div>
                <div class="content">
                    <div class="tool" help="Start Call Recording">
                        <div name="record_call[action=start]" class="action ui-draggable">
                            <div class="icon medium app_sm conference">
                            </div>
                            <div class="tool_name">
                                Start Call Recording
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="Stop Call Recording">
                        <div name="record_call[action=stop]" class="action ui-draggable">
                            <div class="icon medium app_sm conference">
                            </div>
                            <div class="tool_name">
                                Stop Call Recording
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="app_list_nav">
                    </div>
                </div>
            </div>
            <div id="Call Forwarding" name="Call Forwarding" class="category inactive hidden">
                <div class="open">
                    Call Forwarding
                </div>
                <div class="content">
                    <div class="tool" help="Enable call forwarding (using the last forwaded number)">
                        <div name="call_forward[action=activate]" class="action ui-draggable">
                            <div class="icon medium app_sm rightarrow">
                            </div>
                            <div class="tool_name active">
                                Enable call forwarding
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="Disable call forwarding">
                        <div name="call_forward[action=deactivate]" class="action ui-draggable">
                            <div class="icon medium app_sm rightarrow">
                            </div>
                            <div class="tool_name">
                                Disable call forwarding
                            </div>
                        </div>
                    </div>
                    <div class="tool" help="Update the call forwarding number">
                        <div name="call_forward[action=update]" class="action ui-draggable">
                            <div class="icon medium app_sm rightarrow">
                            </div>
                            <div class="tool_name">
                                Update call forwarding
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="app_list_nav">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{% javascript %}
     $('.category .open').click(function () {
                var current = $(this);

                $('.category .content').hide();
                $('.category').removeClass('active').addClass('inactive');

                $(this).parent('.category').removeClass('inactive').addClass('active');
                $(this).siblings('.content').show();
            });
{% endjavascript %}

