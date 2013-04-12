Shoka - 浙大图书馆书目检索客户端
=====

喵。

等待文档

预计时间3周-1个月 (嗯我就是求个push><)

## 捉急的初代文档

### Step 1 

http://webpac.zju.edu.cn/X?op=find&base=zju01&code=wrd&request=[search_key]

结果:

<?xml version = "1.0" encoding = "UTF-8"?>
<find>
<set_number>015901</set_number>
<no_records>000000012</no_records>
<no_entries>000000012</no_entries>
<session-id>PELPJJ6T2SA4T3YEEVK7T8QGIV6IXAPHA39LAV3K7DT5YC2SQM</session-id>
</find>

其中set_number是结果集合?(cache的?), no_entries是结果数量

### Step 2

http://webpac.zju.edu.cn/X?op=present&set_no=[set_number]&set_entry=[1,2,3等等需要显示的结果]&format=marc

每个<record>中的<doc_number>即为图书id, 可以用find-doc显示书籍信息(虽然跟present里面的显示的一样, http://webpac.zju.edu.cn/X?op=find-doc&base=zju01&doc_number=000016487)

### Step 3

http://webpac.zju.edu.cn/X?op=item-data&base=zju01&doc_number=[doc_number]

查询单册信息

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
