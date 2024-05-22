{%- macro normalize_null_values(column_name, dtype) -%}
    case {{ column_name }}
        when 'None' then null
        when 'nan' then null
        when 'NaT' then null
        when '' then null
        when 'N/A' then null
        when 'null' then null
        when '"null"' then null
        when ' ' then null
        when '-' then null
        when '"' then null
        when '"N/A"' then null
    {%- if dtype == 'int' %}
        else nullif(nullif(regexp_replace({{ column_name }}, '[^0-9.-]', '', 1, 'ip'), ''), '.')
    end::float::int
    {%- elif dtype == 'bigint' %}
        else nullif(regexp_replace({{ column_name }}, '[^0-9.-]', '', 1, 'ip'), '')
    end::float8::bigint
    {%- elif dtype == 'float' %}
        else nullif(regexp_replace({{ column_name }}, '[^0-9.-]', '', 1, 'ip'), '')
    end::float
    {%- elif dtype == 'float8' %}
        else nullif(regexp_replace({{ column_name }}, '[^0-9.-]', '', 1, 'ip'), '')
    end::float8
    {%- elif dtype == 'date' %}
        else case
                when regexp_count({{ column_name }}, '^[[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])]*') > 0 then {{ column_name }}
                else null
            end
    end::datetime::date
    {%- elif dtype == 'datetime' %}
        else case
                when regexp_count({{ column_name }}, '^[[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1]) (0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])]*') > 0 then {{ column_name }}
                when regexp_count({{ column_name }}, '^[[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])T(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])]*') > 0 then {{ column_name }}
                when regexp_count({{ column_name }}, '^[[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])]*') > 0 then {{ column_name }}
                else null
            end
    end::datetime
    {%- else %}
        else {{ column_name }}
    end
    {%- endif %}
{%- endmacro -%}