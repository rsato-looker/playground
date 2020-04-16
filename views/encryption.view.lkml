#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: encryption {
  sql_table_name: lookvr_vg.companys ;;

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: name {
    type: string
    sql: convert(
          AES_DECRYPT(UNHEX(${TABLE}.name), '{{_user_attributes['decryption_pass']}}')
          USING utf8
        ) ;;
  }

  dimension: nickname {
    type: string
    sql: ${TABLE}.nickname ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
}
