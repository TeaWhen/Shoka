Shoka - 浙大图书馆书目检索客户端
=====

[![Build Status](https://travis-ci.org/TeaWhen/Shoka.png?branch=master)](https://travis-ci.org/TeaWhen/Shoka)

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

结果：
```xml
<find-doc>
  <script/>
  <record>
    <metadata>
      <oai_marc>
        <fixfield id="FMT">BK</fixfield>
        <fixfield id="LDR">^^^^^nam0^2200313^^^450^</fixfield>
        <fixfield id="001">LCL52000381189</fixfield>
        <fixfield id="005">20130219134024.4</fixfield>
        <varfield id="010" i1=" " i2=" ">
          <subfield label="a">978-7-121-18659-2</subfield>
          <subfield label="d">CNY89.00</subfield>
        </varfield>
        <varfield id="092" i1=" " i2=" ">
          <subfield label="a">CN</subfield>
          <subfield label="b">WHSX961-0859</subfield>
        </varfield>
        <varfield id="100" i1=" " i2=" ">
          <subfield label="a">20130219d2013^^^^em^y0chiy0121^^^^ea</subfield>
        </varfield>
        <varfield id="101" i1="1" i2=" ">
          <subfield label="a">chi</subfield>
          <subfield label="c">eng</subfield>
        </varfield>
        <varfield id="102" i1=" " i2=" ">
          <subfield label="a">CN</subfield>
          <subfield label="b">110000</subfield>
        </varfield>
        <varfield id="105" i1=" " i2=" ">
          <subfield label="a">a^^^z^^^001yy</subfield>
        </varfield>
        <varfield id="106" i1=" " i2=" ">
          <subfield label="a">r</subfield>
        </varfield>
        <varfield id="200" i1="1" i2=" ">
          <subfield label="a">真实世界的Python仪器监控</subfield>
          <subfield label="A">zhen shi shi jie de Pythonyi qi jian kong</subfield>
          <subfield label="d">= Real world instrumentation with Python</subfield>
          <subfield label="e">数据采集与控制系统自动化</subfield>
          <subfield label="f">J.M. Hughes著</subfield>
          <subfield label="g">OBP Group译</subfield>
          <subfield label="z">eng</subfield>
        </varfield>
        <varfield id="210" i1=" " i2=" ">
          <subfield label="a">北京</subfield>
          <subfield label="c">电子工业出版社</subfield>
          <subfield label="d">2013.1</subfield>
        </varfield>
        <varfield id="215" i1=" " i2=" ">
          <subfield label="a">xxvii, 571页</subfield>
          <subfield label="c">图</subfield>
          <subfield label="d">24cm</subfield>
        </varfield>
        <varfield id="306" i1=" " i2=" ">
          <subfield label="a">本书简体中文版专有出版权由O'Reilly Media, Inc.授予电子工业出版社</subfield>
        </varfield>
        <varfield id="314" i1=" " i2=" ">
          <subfield label="a">责任者规范汉译姓: 休斯</subfield>
        </varfield>
        <varfield id="320" i1=" " i2=" ">
          <subfield label="a">有索引</subfield>
        </varfield>
        <varfield id="330" i1=" " i2=" ">
          <subfield label="a">
            本书主要探讨如何运用Python快速构建自动化仪器控制系统, 帮助读者了解如何通过自行开发应用程序来监视或者控制仪器硬件。本书内容涵盖了从接线到建立接口, 直到完成可用软件的整个过程。
          </subfield>
        </varfield>
        <varfield id="333" i1=" " i2=" ">
          <subfield label="a">本书适合需要进行仪表控制、机器人、数据采集、过程控制等相关工作的读者阅读参考</subfield>
        </varfield>
        <varfield id="510" i1="1" i2=" ">
          <subfield label="a">Real world instrumentation with Python</subfield>
          <subfield label="z">eng</subfield>
        </varfield>
        <varfield id="517" i1="1" i2=" ">
          <subfield label="a">数据采集与控制系统自动化</subfield>
          <subfield label="A">shu ju cai ji yu kong zhi xi tong zi dong hua</subfield>
        </varfield>
        <varfield id="606" i1="0" i2=" ">
          <subfield label="a">软件工具</subfield>
          <subfield label="A">ruan jian gong ju</subfield>
          <subfield label="x">程序设计</subfield>
        </varfield>
        <varfield id="690" i1=" " i2=" ">
          <subfield label="a">TP311.56</subfield>
          <subfield label="v">5</subfield>
        </varfield>
        <varfield id="701" i1=" " i2="1">
          <subfield label="a">休斯</subfield>
          <subfield label="A">xiu si</subfield>
          <subfield label="g">(Hughes, John M.)</subfield>
          <subfield label="4">著</subfield>
        </varfield>
        <varfield id="712" i1="0" i2="2">
          <subfield label="a">OBP Group</subfield>
          <subfield label="4">译</subfield>
        </varfield>
        <varfield id="801" i1=" " i2="0">
          <subfield label="a">CN</subfield>
          <subfield label="b">三新书业</subfield>
          <subfield label="c">20130222</subfield>
        </varfield>
        <varfield id="CAT" i1=" " i2=" ">
          <subfield label="c">20130313</subfield>
          <subfield label="l">LCL52</subfield>
          <subfield label="h">1337</subfield>
        </varfield>
        <varfield id="CAT" i1=" " i2=" ">
          <subfield label="a">BATCH</subfield>
          <subfield label="b">00</subfield>
          <subfield label="c">20130313</subfield>
          <subfield label="l">LCL52</subfield>
          <subfield label="h">1337</subfield>
        </varfield>
        <varfield id="CAT" i1=" " i2=" ">
          <subfield label="a">ACQ0101</subfield>
          <subfield label="b">00</subfield>
          <subfield label="c">20130314</subfield>
          <subfield label="l">ZJU01</subfield>
          <subfield label="h">1346</subfield>
        </varfield>
        <varfield id="LEV" i1=" " i2=" ">
          <subfield label="a">ACQ</subfield>
        </varfield>
      </oai_marc>
    </metadata>
  </record>
  <session-id>Q3QEB8PU4LI9EGMH584EVM1PXXAYGCQRHC8C2YIV4MSBT523JI</session-id>
</find-doc>
```


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
