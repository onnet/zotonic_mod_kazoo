<div class="modal-body">
    <div class="form-group">
        <label class="control-label">{_ Editor version _}</label>
        <div>
            {% for id, version, version_txt, date_txt in [
                ["e", "newest",       "always use newest available", ""],
                ["d", "4.2.4",  "4.2.4", "Aug 17 2015"],
                ["c", "4.1.6",  "4.1.6", "Oct 08 2014"],
                ["b", "4.0.26", "4.0.26", "May 06 2014"],
                ["a", "3.5.0",  "3.5.0", "May 03 2012"]
            ] %}
                <div class="radio">
                    <label>
                        <input type="radio" name="version" id="{{ #config.id }}" value="{{ version|escape }}" {% if m.config.mod_editor_tinymce.version.value|escape==version%} checked{% endif %} /> {{ version_txt }} <span class="text-muted">{{ date_txt }}</span>
                    </label>
                    {% wire
                        id=#config.id
                        type="click"
                        action={
                            config_toggle
                            module="mod_kazoo"
                            key="version"
                        }
                    %}
                </div>
            {% endfor %}
        </div>
    </div>
</div>


<div class="form-group">
    <div class="checkbox">
        <label>
            <input type="checkbox" name="pref_tz_fixed" id="pref_tz_fixed" value="1"
                {% if m.config.mod_l10n.timezone_is_fixed.value %}checked{% endif %}
            />
            {_ Fix timezone, show all dates in the above timezone. _}
        </label>
    </div>
    {% wire id="pref_tz_fixed"
        action={config_toggle module="mod_l10n" key="timezone_is_fixed"}
    %}

    <p class="help-block">
        {_ This forces the timezone to the configured timezone. Irrespective of the timezone selected by the user or user-agent. _}
    </p>
</div>

<div class="form-group">
        <label>
            {_ WSS Port _}:
            <input type="text" name="wss_port" id="wss_port" value="{{ m.config.mod_kazoo.wss_port.value }}" placeholder="5065" />
        </label>
    {% wire id="wss_port" action={config_toggle module="mod_kazoo" key="wss_port"} %}

    <p class="help-block">
        {_ Just WSS port setup. _}
    </p>
</div>


<div class="modal-footer">
    {% button class="btn btn-default" text=_"Close" action={dialog_close} tag="a" %}
</div>

