---
layout: page
title: Mods
permalink: /mods/
---

The following mods are currently available for download on the repository.

{% for mod in page.mods %}
  <div class="mod-entry" onclick="window.location.href='/mods/{{mod.id | escape }}/'">
    <div class="mod-version">{{ mod.version | xml_escape }}</div>
    <div class="mod-name">{{ mod.name | xml_escape }}</div>
    <div class="mod-description">{{ mod.description | truncate: 100 | xml_escape }}</div>
  </div>
{% endfor %}
