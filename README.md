Shoka - 浙大图书馆书目检索客户端
=====

[![Build Status](https://travis-ci.org/TeaWhen/shoka.png?branch=master)](https://travis-ci.org/TeaWhen/shoka)

## ideas

整合豆瓣评价/评论/网上书店售价信息

## 初代文档

`base=zju01`为中文文献库

`base=zju09`为西文文献库

### Step 1 

`http://webpac.zju.edu.cn/X?op=find&base=zju01&code=wrd&request=[search_key]`

结果:

```xml
<?xml version = "1.0" encoding = "UTF-8"?>
<find>
<set_number>015901</set_number>
<no_records>000000012</no_records>
<no_entries>000000012</no_entries>
<session-id>PELPJJ6T2SA4T3YEEVK7T8QGIV6IXAPHA39LAV3K7DT5YC2SQM</session-id>
</find>
```

其中set_number是结果集合?(cache的?), no_entries是结果数量

### Step 2

`http://webpac.zju.edu.cn/X?op=present&set_no=[set_number]&set_entry=[1,2,3等等需要显示的结果]&format=marc`

每个`<record>`中的`<doc_number>`即为图书id, 可以用find-doc显示书籍信息(虽然跟present里面的显示的一样, `http://webpac.zju.edu.cn/X?op=find-doc&base=zju01&doc_number=[doc_number]`)

### Step 3

`http://webpac.zju.edu.cn/X?op=item-data&base=zju01&doc_number=[doc_number]`

查询单册信息

```xml
<item>
<rec-key>000016487000020</rec-key>
<barcode>000001272347</barcode>
<sub-library>紫金港基础流通书库</sub-library> 分馆
<collection>BL101</collection> 索书号
<item-status>12</item-status> 是否可借还的状态：12可借
<note>ZJU01ZULB CC</note>
<call-no-1>C91-091/CA1</call-no-1>
<call-no-2/>
<description/>
<chronological-i/>
<chronological-j/>
<chronological-k/>
<enumeration-a/>
<enumeration-b/>
<enumeration-c/>
<library>ZJU50</library>
<on-hold>N</on-hold>
<requested>N</requested>
<expected>N</expected>
<loan-status>A</loan-status> 是否已经借出：A已经借出
<loan-in-transit>N</loan-in-transit>
<loan-due-date>20130409</loan-due-date> 应还日期
<loan-due-hour>2359</loan-due-hour>
</item>
```

### CNMARC格式结构

CNMARC书目记录字段按功能划分为以下九个功能块,字段标识符的第一个数字（最左边）表示字段所属的功能块。

0. 标识块：主要由记录控制号、国际标准书号(ISBN)、统一书刊号等字段构成。常用字段有：001、005、009、010、020、091、092。
1. 编码信息块：主要由描述作品的各个方面的编码数据，如一般处理数据、作品语种、出版国别等编码字段构成。常用字段有：100、101、102、105、106。
2. 著录信息块：主要由包括ISBD和中国国家标准《文献著录准则》规定的除附注项和文献标准号码以外的全部著录项目，如题名与责任者项、版本项、出版发行项、载体形态项、丛书项和文献特殊细节项等字段构成。常用字段有：200、205、210、215、225。
3. 附注项：主要包括对作品各方面的文字说明，由一般附注、内容附注、提要和文摘、采访信息附注等字段构成。常用字段有：300、303、304、308、320、325、327、328、330、345。
4. 连接块：主要包括以数字和文字形式对其它记录的标准连接。常用字段有：410、411、423、451、453、454、461、462、463、464。
5. 相关题名块：主要包括作为检索点的本作品的其它题名，由统一题名、并列题名、其他题名、编目员补充的附加题名等字段构成。常用字段有：500、510、512、514、515、516、517、540、541。
6. 主题分析块：主要由分类、主题标识、非控主题词等字段构成。常用字段有：600、601、605、606、607、610、690、692。
7. 责任者块：主要包括对作品负有主任的个人及团体的名称。并区分为主要责任者、等同责任者及次要责任者等字段构成。常用字段有：701、702、711、712。
8. 国际使用块：主要包括对负有责任的机构的标识，有记录来源字段构成。常用字段：801。
9. 国内使用块：主要设置馆藏信息字段，如馆藏代码、登录号、分类号、书次号、入藏卷次、年代范围等字段。常用字段有：905、989、990。
