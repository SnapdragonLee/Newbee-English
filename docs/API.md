[TOC]



# API 参考文档

本文档为 Newbee-English API 文档，参考请参见 Reference.



## API 完成清单

**管理端：**

- [x] 登录

- [x] 登出

- [x] 查看管理员用户名

- [x] 查看用户信息

- [x] 搜索用户信息

- [x] 删除用户信息

- [x] 查看题目列表

- [x] 查看题目信息

- [x] 上传题目

- [x] 修改题目

- [x] 删除题目

- [x] 是否有题解待处理

- [x] 查看题解

- [x] 删除题解

- [x] 查看公告

- [x] 修改公告

  

**用户端：**

- [x] 登录
- [x] 查看用户名
- [x] 修改用户名
- [x] 查看错题本
- [x] 向错题本添加错题
- [x] 删除错题本中的题
- [x] 查看刷题记录
- [x] 用户清空刷题记录
- [x] 查看做题详情
- [x] 查看刷题统计
- [x] 获取题目题面
- [x] 获取题目答案
- [x] 查看题解
- [x] 发表题解
- [x] 为题解点赞
- [x] 举报题解
- [x] 查看排名
- [x] 查看公告





## 全局设置

### 返回值设置(ret)

| ret值 | 含义                              | 后续操作     | 备注                               |
| ----- | --------------------------------- | ------------ | ---------------------------------- |
| 0     | 正常                              | 继续执行     |                                    |
| 1     | 用户sessionid错误，处于未登录态   | 返回登录界面 | 除登录接口外，所有接口均可返回此值 |
| 2     | 管理员sessionid错误，处于未登录态 | 返回登录界面 | 除登录接口外，所有接口均可返回此值 |
| 3     | 其他错误                          |              | msg信息表示错误原因                |



## 管理端

本域提到的 api 权限归于管理员。

### 登录

管理员使用该接口进行登录。前端发送的登录请求中包含用户名、密码。 后端接收后，对账号密码的正确性进行校验。 如果校验通过，服务端在响应消息头使用set_cookie 存入sessionid。



#### 请求

**请求头**

```
POST /api/admin/login
Content-Type: application/json
```

**消息体**

```json
{
  "name" : "张三",
  "pwd" : "123456"
}
```

**参数信息**

| 参数名 | 示例   | 必要性 | 含义               | 类型   |
| ------ | ------ | ------ | ------------------ | ------ |
| name   | 张三   | 必有   | 管理员登录的用户名 | string |
| pwd    | 123456 | 必有   | 管理员登录的密码   | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
set_cookie: sessionid=<sessionid数值>
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret≠0):

```json
{
  "ret": 3,
  "msg": "用户名或密码错误"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | :--- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 登出

#### 请求

**请求头**

```
DELETE /api/admin/logout
Cookie: sessionid=<sessionid数值>
```



#### 响应

后端清除对应session，然后返回响应消息。

**响应头**

```
200 OK
Content-Type: application/json
Set-Cookie: sessionid=""
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 查看管理员用户名

此 api 可返回管理员的昵称

#### 请求

**请求头**

```
GET /api/admin/getname
Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******",
  "name": "小赵"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型   |
| ------ | ---- | ------ | ------------ | ------ |
| ret    | 0    | 必有   | 是否正常返回 | int    |
| name   | 小赵 | 必有   | 管理员昵称   | string |



### 查看用户信息

管理员查看用户信息。

#### 请求

**请求头**

```
GET /api/admin/list_user?pagenumber=2&pagesize=12&sorttype=1&sortname=numc
Cookie: sessionid=<sessionid数值>
```



**参数信息**

| 参数名     | 示例 | 必要性 | 含义                                                         | 类型   |
| ---------- | ---- | ------ | ------------------------------------------------------------ | ------ |
| pagenumber | 2    | 必有   | 获取第几页的信息                                             | int    |
| pagesize   | 12   | 必有   | 每页列出的账号数量                                           | int    |
| sorttype   | 1    | 必有   | 排序方式（正序为 1，倒序为 0）                               | int    |
| sortname   | numc | 必有   | 按照哪个属性排序（查看信息则为空，numc为做过的完型数量，numm为做过的选择题数量，numr为做过的阅读题数量） | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******",
  "list": [
    {
      "name": "小赵",
      "numm": "888",
      "numc": "777",
      "numr": "666",
      "right_choice_que": "542",
      "right_reading_que": "245",
      "right_cloze_que": "335",
      "solution_sum":12,
       "likes": 14,
      "reports":5
    },
    {
      "name": "小李",
      "numm": "888",
      "numc": "999",
      "numr": "555",
      "right_choice_que": "342",
      "right_reading_que": "515",
      "right_cloze_que": "235",
      "solution_sum":16,
       "likes": 2,
      "reports":1
    }
  ],
  "total": 32
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义           | 类型info |
| ------ | ------- | ------ | -------------- | -------- |
| ret    | 0       | 必有   | 是否正常返回   | int      |
| list   | [{},{}] | 必有   | 所有用户的信息 | list     |
| total  | 32      | 必有   | 所有用户的数量 | int      |

其中 `list` 是包含多个查找结果的列表，每个结果的参数信息如下所示：

| 参数名            | 示例 | 必要性 | 含义                         | 类型   |
| ----------------- | ---- | ------ | ---------------------------- | ------ |
| name              | 小赵 | 必有   | 用户名                       | string |
| numm              | 888  | 必有   | 用户做过的单选数量           | int    |
| numc              | 777  | 必有   | 用户做过的完型数量           | int    |
| numr              | 666  | 必有   | 用户做过的阅读数量           | int    |
| right_choice_que  | 542  | 必有   | 用户做对的选择数量           | int    |
| right_reading_que | 254  | 必有   | 用户做对的阅读数量           | int    |
| right_cloze_que   | 335  | 必有   | 用户做对的完型数量           | int    |
| solution_sum      |      | 必有   | 用户发表的题解总数           | int    |
| likes             |      | 必有   | 用户发表的题解收到的点赞总数 | int    |
| reports           |      | 必有   | 用户发表的题解收到的举报总数 | int    |



### 搜索用户信息

管理员通过此api根据用户的用户名搜索用户信息。

#### 请求

**请求头**

```
GET /api/admin/designated_user?name=test&pagesize=12&pagenumber=1
Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "username" : "test",
  "pagenumber" : "2",
  "pagesize" : "12"
}
```

**参数信息**

| 参数名     | 示例 | 必要性 | 含义               | 类型   |
| ---------- | ---- | ------ | ------------------ | ------ |
| username   | test | 必有   | 待搜索的用户名     | string |
| pagenumber | 2    | 必有   | 获取第几页的信息   | int    |
| pagesize   | 12   | 必有   | 每页列出的账号数量 | int    |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******",
  "list": [
    {
      "name": "小明",
      "numm": "888",
      "numc": "777",
      "numr": "666",
       "right_choice_que": "542",
      "right_reading_que": "245",
      "right_cloze_que": "335",
      "solution_sum":20,
       "likes": 33,
      "reports":10
    },
    {
      "name": "小红",
      "numm": "888",
      "numc": "999",
      "numr": "555",
      "right_choice_que": "542",
      "right_reading_que": "245",
      "right_cloze_que": "335",
      "solution_sum":12,
       "likes": 9,
      "reports":5
    }
  ],
  "total": 32
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义               | 类型info |
| ------ | ------- | ------ | ------------------ | -------- |
| ret    | 0       | 必有   | 是否正常返回       | int      |
| list   | [{},{}] | 必有   | 搜索到的用户的信息 | list     |
| total  | 32      | 必有   | 搜索到的用户的数量 | int      |

其中 `list` 是包含多个查找结果的列表，每个结果的参数信息如下所示：

| 参数名            | 示例 | 必要性 | 含义                         | 类型   |
| ----------------- | ---- | ------ | ---------------------------- | ------ |
| name              | test | 必有   | 用户名                       | string |
| numm              | 888  | 必有   | 单选数量                     | string |
| numc              | 777  | 必有   | 完型数量                     | string |
| numr              | 666  | 必有   | 阅读数量                     | string |
| right_choice_que  | 542  | 必有   | 用户做对的选择数量           | int    |
| right_reading_que | 254  | 必有   | 用户做对的阅读数量           | int    |
| right_cloze_que   | 335  | 必有   | 用户做对的完型数量           | int    |
| solution_sum      |      | 必有   | 用户发表的题解总数           | int    |
| likes             |      | 必有   | 用户发表的题解收到的点赞总数 | int    |
| reports           |      | 必有   | 用户发表的题解收到的举报总数 | int    |



### 删除用户信息

管理员可以通过此 api 删除用户信息，支持批量删除

#### 请求

**请求头**

```
 DELETE /api/admin/list_user?userid=1&userid=22
 Cookie: sessionid=<sessionid数值>
 Content-Type: application/json
```

**消息体**

```json
{
  "userid" : ['1'，'22']
}
```

**参数信息**

| 参数名 | 示例        | 必要性 | 含义               | 类型 |
| ------ | ----------- | ------ | ------------------ | ---- |
| userid | ['1'，'22'] | 必有   | 被删除账户的用户ID | list |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

正常返回(ret = 0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回 (ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | :--- |
| ret    | 0    | 必有   | 是否正常返回 | int  |





### 查看题目列表

#### 请求

**请求头**

```
 GET /api/admin/list_question?pagenumber=2&pagesize=12&type=choice_question&title=
 Cookie: sessionid=<sessionid数值>
```



**参数信息**

| 参数名     | 示例                                                         | 必要性 | 含义                     | 类型   |
| ---------- | ------------------------------------------------------------ | ------ | ------------------------ | ------ |
| pagenumber | 2                                                            | 必有   | 获取第几页的信息         | int    |
| pagesize   | 12                                                           | 必有   | 每页列出的题目数量       | int    |
| type       | choice_question 选择题<br />cloze_question 完形题<br />reading_question阅读题 | 必有   | 要查看题目的类型         | string |
| title      |                                                              | 可选   | 题目的标题，用于模糊查找 | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******",
  "list": [
    {
      "id": 123,
      "title": "Lily was so ___looking at the picture that she forgot the time",
      "sub_que_num": "2",
      "has_bad_solution": 1
    },
    {
      "id": 124,
      "title": "Lily was so ___looking at the picture that she forgot the time",
      "sub_que_num": "3",
      "has_bad_solution": 0
    }
  ],
  "total": 32
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义                   | 类型info |
| ------ | ------- | ------ | ---------------------- | -------- |
| ret    | 0       | 必有   | 是否正常返回           | int      |
| list   | [{},{}] | 必有   | 某个类型所有题目的信息 | list     |
| total  | 32      | 必有   | 某个类型题目的总数量   | int      |

其中`list`是包含多个查找结果的列表，每个结果的参数信息如下所示：

| 参数名           | 示例                                                         | 必要性 | 含义                                                         | 类型   |
| ---------------- | ------------------------------------------------------------ | ------ | ------------------------------------------------------------ | ------ |
| id               | 123                                                          | 必有   | 题目的id                                                     | int    |
| title            | Lily was so ___looking at the picture that she forgot the time | 必有   | 题目的标题                                                   | string |
| sub_que_num      | 2                                                            | 必有   | 所含小题数量                                                 | int    |
| has_bad_solution | 1或0                                                         | 必有   | 表示该题目的所有小题中，是否有需要审查的题解，1表示有，0表示没有 | int    |



### 查看图表数据

#### 请求

**请求头**

```
 GET /api/admin/graph
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0)

```json
{
  "usernumber": "1024",
  "questionnumber": "324",
  "bad_solution_number": "532",
  "quertions_number": [
    {
      "value": "1048",
      "name": "单项选择"
    },
    {
      "value": "320",
      "name": "完型填空"
    },
    {
      "value": "152",
      "name": "阅读理解"
    }
  ],
  "choice_question_top5": [
    {
      "value": "322",
      "code": "姜哥"
    },
    {
      "value": "312",
      "code": "小赵"
    },
    {
      "value": "234",
      "code": "小李"
    },
    {
      "value": "122",
      "code": "小A"
    },
    {
      "value": "110",
      "code": "小B"
    }
  ],
  "reading_question_top5": [
    {
      "value": "322",
      "code": "姜哥"
    },
    {
      "value": "312",
      "code": "小赵"
    },
    {
      "value": "234",
      "code": "小李"
    },
    {
      "value": "122",
      "code": "小A"
    },
    {
      "value": "110",
      "code": "小B"
    }
  ],
  "cloze_question_top5": [
    {
      "value": "322",
      "code": "姜哥"
    },
    {
      "value": "312",
      "code": "小赵"
    },
    {
      "value": "234",
      "code": "小李"
    },
    {
      "value": "122",
      "code": "小A"
    },
    {
      "value": "110",
      "code": "小B"
    }
  ]
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名                | 示例 | 必要性 | 含义                            | 类型 |
| --------------------- | ---- | ------ | ------------------------------- | ---- |
| usernumber            | 1024 | 必有   | 用户个数                        | int  |
| questonnumber         | 488  | 必有   | 题库中题目个数                  | int  |
| bad_solution_number   | 534  | 必有   | 待处理的坏题解个数              | int  |
| questions_number      |      | 必有   | 各个题型的数量                  | 列表 |
| choice_question_top5  |      | 必有   | 完成单选数目最多的5位用户和数据 | 列表 |
| cloze_question_top5   |      | 必有   | 完成完型数目最多的5位用户和数据 | 列表 |
| reading_question_top5 |      | 必有   | 完成阅读数目最多的5位用户和数据 | 列表 |

questions_number的参数如下：

| 参数名 | 示例                           | 必要性 | 含义       | 类型 |
| ------ | ------------------------------ | ------ | ---------- | ---- |
| value  | 1048                           | 必有   | 题型的数量 | int  |
| name   | 单项选择（完形填空，阅读理解） | 必有   | 题型的名称 | str  |

choice_question_top5，cloze_question_top5，reading_question_top5的参数如下

| 参数名 | 示例 | 必要性 | 含义                                    | 类型 |
| ------ | ---- | ------ | --------------------------------------- | ---- |
| value  | 322  | 必有   | 用户完成的单选数目（完型数目/阅读数目） | int  |
| code   | 姜哥 | 必有   | 用户的名称                              | str  |



### 查看题目信息

#### 请求

**请求头**

```
 GET /api/admin/designated_question?id=1
 Cookie: sessionid=<sessionid数值>
```



**参数信息**

| 参数名 | 示例 | 必要性 | 含义             | 类型   |
| ------ | ---- | ------ | ---------------- | ------ |
| ID     | 2    | 必有   | 被查看的题目的ID | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******",
  "title": "",
  "text": "",
  "sub_que_num": 2,
  "sub_que": [
    {
      "id": 123,
      "stem": "Lily was so ___looking at the picture that she forgot the time.",
      "number": 1,
      "options": [
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B",
      "has_bad_solution": 1
    },
    {
      "id": 124,
      "stem": "Lily was so ___looking at the picture that she forgot the time.",
      "number": 2,
      "options": [
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B",
      "has_bad_solution": 0
    }
  ]
}
```

错误返回(ret>0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名      | 示例    | 必要性 | 含义                             | 类型info |
| ----------- | ------- | ------ | -------------------------------- | -------- |
| ret         | 0       | 必有   | 是否正常返回                     | int      |
| title       |         | 必有   | 标题                             | string   |
| text        | " "     | 可选   | 阅读、完形的文章，选择题此项为空 | string   |
| sub_que_num | 4       | 必有   | 子题目数目                       | int      |
| sub_que     | [{},{}] | 必有   | 子题目的信息                     | list     |

其中 sub_que 是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名           | 示例                                                         | 必要性 | 含义                                   | 类型   |
| ---------------- | ------------------------------------------------------------ | ------ | -------------------------------------- | ------ |
| id               |                                                              | 必有   | 子题目的id                             | int    |
| stem             | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空             | string |
| number           | 1                                                            | 必有   | 子问题的题号                           | int    |
| options          | ["carefully","careful", "busily","busy"]                     | 必有   | 选项                                   | list   |
| answer           | "B"                                                          | 必有   | 答案                                   | string |
| has_bad_solution | 1或0                                                         | 必有   | 1表示该小题含有待审查的题解，0表示没有 | int    |



### 上传题目

#### 请求

**请求头**

```
 POST /api/admin/designated_question
 Cookie: sessionid=<sessionid数值>
 Content-Type: application/json
```

**消息体**

```json
{
  "type": "reading_question",
  "title": "标题",
  "text": "文章在这里",
  "sub_que_num": 2,
  "sub_que": [
    {
      "stem": "Lily was so ___looking at the picture that she forgot the time.",
      "number": 1,
      "options": [
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"
    },
    {
      "stem": "Lily was so ___looking at the picture that she forgot the time.",
      "number": 2,
      "options": [
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"
    }
  ]
}
```

**参数信息**

| 参数名      | 示例                                                         | 必要性 | 含义                             | 类型   |
| ----------- | ------------------------------------------------------------ | ------ | -------------------------------- | ------ |
| type        | choice_question 选择题<br />cloze_question 完形题<br />reading_question阅读题 | 必有   | 题目类型                         | string |
| title       |                                                              | 必有   | 标题                             | string |
| text        | " "                                                          | 可选   | 阅读、完形的文章，选择题此项为空 | string |
| sub_que_num | 4                                                            | 必有   | 子题目数目                       | int    |
| sub_que     | [{},{}]                                                      | 必有   | 子题目的信息                     | list   |

其中 sub_que 是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名  | 示例                                                         | 必要性 | 含义                       | 类型   |
| ------- | ------------------------------------------------------------ | ------ | -------------------------- | ------ |
| stem    | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空 | string |
| number  | 1                                                            | 必有   | 子问题的题号               | int    |
| options | ["carefully","careful", "busily","busy"]                     | 必有   | 选项                       | list   |
| answer  | "B"                                                          | 必有   | 答案                       | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret = 0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret≠0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 修改题目

管理员可通过此 api 修改题目

#### 请求

**请求头**

```
PUT /api/admin/designated_question
Cookie: sessionid=<sessionid数值>
Content-Type: application/json
```

**消息体**

```json
{
  "problemid": 1,
  "type": "reading_question",
  "title": "修改后的题目1",
  "text": "修改后的文章",
  "sub_que_num": 2,
  "sub_que": [
    {
      "stem": "修改后的第一题第1小题",
      "number": 1,
      "options": [
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"
    },
    {
      "stem": "修改后的第一题第2小题.",
      "number": 2,
      "options": [
        "hhhhhhhhhhh",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "C"
    }
  ]
}
```

**参数信息**

| 参数名      | 示例                                                         | 必要性 | 含义                             | 类型   |
| ----------- | ------------------------------------------------------------ | ------ | -------------------------------- | ------ |
| problemid   |                                                              | 必有   | 题目的id                         | int    |
| type        | choice_question 选择题<br />cloze_question 完形题<br />reading_question阅读题 | 必有   | 题目类型                         | string |
| text        | " "                                                          | 可选   | 阅读、完形的文章，选择题此项为空 | string |
| sub_que_num | 4                                                            | 必有   | 子题目数目                       | int    |
| sub_que     | [{},{}]                                                      | 必有   | 子题目的信息                     | list   |

其中 sub_que 是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名  | 示例                                                         | 必要性 | 含义                       | 类型   |
| ------- | ------------------------------------------------------------ | ------ | -------------------------- | ------ |
| "stem"  | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空 | string |
| number  | 1                                                            | 必有   | 子问题的题号               | int    |
| options | ["carefully","careful", "busily","busy"]                     | 必有   | 选项                       | list   |
| answer  | "B"                                                          | 必有   | 答案                       | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret = 0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 删除题目

管理员可通过此 api 删除题目

#### 请求

**请求头**

```
DELETE /api/admin/list_question?question=11&question=21
Cookie: sessionid=<sessionid数值>
Content-Type: application/json
```



**参数信息**

| 参数名   | 示例 | 必要性 | 含义               | 类型 |
| -------- | ---- | ------ | ------------------ | ---- |
| question | [ ]  | 必有   | 需要被删除的题目id | list |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret = 0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 是否有题解待处理

#### 请求

**请求头**

```
 GET /api/admin/has_bad_solution
 Cookie: sessionid=<sessionid数值>
```

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret = 0):

```json
{
  "ret": 0,
  "msg": "******",
  "has_bad_solution": 1
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名           | 示例 | 必要性 | 含义                                 | 类型 |
| ---------------- | ---- | ------ | ------------------------------------ | ---- |
| has_bad_solution | 1    | 必有   | 是否有待处理题解，1表示有，0表示没有 | int  |



### 查看题解

#### 请求

**请求头**

```
 GET /api/admin/solution?sub_question_id=3
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义             | 类型 |
| ------ | ---- | ------ | ---------------- | ---- |
| id     | 3    | 必有   | 题解对应小题的id | int  |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret = 0):

```json
{
  "ret": 0,
  "solutions": [
    {
      "id": 123,
      "content": "",
      "likes": 4,
      "reports": 2,
      "bad_solution": 0,
        "author_username":"小明",
      "author_solution_sum":10,
      "author_likes": 34,
       "author_reports": 2
    },
    {
      "id": 124,
      "content": "",
      "likes": 1,
      "reports": 8,
      "bad_solution": 1,
        "author_username":"小红",
      "author_solution_sum":10,
      "author_likes": 17,
       "author_reports": 10
    }
  ],
  "total": 2
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名    | 示例 | 必要性 | 含义             | 类型 |
| --------- | ---- | ------ | ---------------- | ---- |
| ret       | 0    | 必有   | 是否正常返回     | int  |
| solutions |      | 必有   | 题解字典的列表   |      |
| total     |      | 必有   | 该小题的题解总数 | int  |

solutions结构如下

| 参数名              | 示例 | 必要性 | 含义                                       | 类型   |
| ------------------- | ---- | ------ | ------------------------------------------ | ------ |
| id                  |      | 必有   | 题解id                                     | int    |
| content             |      | 必有   | 题解内容                                   | string |
| likes               |      | 必有   | 该题解点赞数                               | int    |
| reports             |      | 必有   | 该题解举报数                               | int    |
| bad_solution        |      | 必有   | =1表示该题解被举报比例过大，需要管理员审查 | int    |
| author_username     |      | 必有   | 该题解的作者的用户名                       | string |
| author_solution_sum |      | 必有   | 该题解作者所发表的所有题解的总数           | int    |
| author_likes        |      | 必有   | 该题解作者所发表的题解收到的点赞总数       | int    |
| author_reports      |      | 必有   | 该题解作者所发表的题解收到的举报总数       | int    |



### 删除题解

#### 请求

**请求头**

```
 DELETE /api/admin/solution?id=1&id=2&id=3
 Cookie: sessionid=<sessionid数值>
```



**参数信息**

| 参数名 | 示例 | 必要性 | 含义           | 类型 |
| ------ | ---- | ------ | -------------- | ---- |
| id     | 3    | 必有   | 被删除的题解ID | int  |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret≠0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | :--- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 管理员认可题解

#### 请求

**请求头**

```
 POST /api/admin/solution
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "solution_id": 123
}
```

**参数信息**

| 参数名      | 示例 | 必要性 | 含义   | 类型 |
| ----------- | ---- | ------ | ------ | ---- |
| solution_id | 1    | 必有   | 题解id | int  |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0)

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```



### 查看操作记录

#### 请求

**请求头**

```
 GET /api/admin/op_record?pagenumber=2&pagesize=12
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0)

```json
{
  "records": [
    {
      "name": "JTL",
      "op_type": "删除",
      "description": "修改后的题目1"
    },
    {
      "name": "JTL",
      "op_type": "修改",
      "description": "修改后的题目1"
    },
    {
      "name": "JTL",
      "op_type": "添加",
      "description": "题目1"
    }
  ],
  "total": 12,
  "ret": 0,
  "msg": "Normal operation."
}
```

异常返回(ret ≠ 0):

```json
{
	"ret": 3,
    "msg": "******"
}
```

**参数信息**

| 参数名  | 示例 | 必要性 | 含义                 | 类型 |
| ------- | ---- | ------ | -------------------- | ---- |
| ret     | 1    | 必有   | 是否正常返回         | int  |
| records |      | 必有   | 操作记录所组成的列表 | 列表 |
|         |      |        |                      |      |

其中 records 中的参数：

| 参数名      | 示例             | 必要性 | 含义             | 类型   |
| ----------- | ---------------- | ------ | ---------------- | ------ |
| name        |                  | 必有   | 管理员用户名     | string |
| op_type     | 添加、修改、删除 | 必有   | 三种操作类型之一 | string |
| description |                  | 必有   | 操作的对象描述   | string |



### 查看公告

#### 请求

**请求头**

```
 GET /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0)

```json
{
  "ret": 0,
  "msg": "******",
  "ancontent": "welcome to NewBee English"
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名    | 示例        | 必要性 | 含义         | 类型   |
| --------- | ----------- | ------ | ------------ | ------ |
| ret       | 1           | 必有   | 是否正常返回 | int    |
| ancontent | welcom to.. | 必有   | 公告内容     | string |



### 修改公告

#### 请求

**请求头**

```
 PUT /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "ancontent": "welcome to NewBee English"
  "antime": {
    "year": "2022",
    "month": "5",
    "day": "9",
    "hour": "14",
    "min": "23",
    "sec": "25"
  }
}
```

**参数信息**

| 参数名    | 示例        | 必要性 | 含义     | 类型       |
| --------- | ----------- | ------ | -------- | ---------- |
| ancontent | welcom to.. | 必有   | 公告内容 | string     |
| ant       | {}          | 必有   | 发布时间 | dictionary |

其中`ant`中的参数信息如下所示：

| 参数名 | 示例 | 必要性 | 含义     | 类型 |
| ------ | ---- | ------ | -------- | ---- |
| year   | 2022 | 必有   | 发布年份 | int  |
| month  | 5    | 必有   | 发布月份 | int  |
| day    | 9    | 必有   | 发布天   | int  |
| hour   | 14   | 必有   | 发布小时 | int  |
| min    | 23   | 必有   | 发布分钟 | int  |
| sec    | 25   | 必有   | 发布秒   | int  |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret≠0):

```json
{
  "ret": 3,
  "msg": "******"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |





## 用户端

本块提到的 api 权限归于用户。

### 登录

#### 请求

**请求头**

```
 POST /api/user/login
```

**消息体**

```json
{
  "code": "xxxxx",
  "username": "微信昵称"
}
```

**参数信息**

| 参数名   | 示例 | 必要性 | 含义                           | 类型   |
| -------- | ---- | ------ | ------------------------------ | ------ |
| code     |      | 必须   | 小程序端发过来的code           | string |
| username |      | 必须   | 用户的微信昵称，作为默认用户名 | string |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
set_cookie: sessionid=<sessionid数值>
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret≠0):

```json
{
  "ret": 3,
  "msg": "取openid失败"
}
```



### 查看用户名

#### 请求

**请求头**

```
 GET /api/user/profile
 Cookie: sessionid=<sessionid数值>
```

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "username": "用户名",
  "msg": "******"
}
```

异常返回(ret≠0):

```json
{
  "ret": 3,
  "msg": "***"
}
```

| 参数名   | 示例 | 必要性 | 含义   | 类型   |
| -------- | ---- | ------ | ------ | ------ |
| username |      | 必有   | 用户名 | string |



### 修改用户名

#### 请求

**请求头**

```
 POST /api/user/profile
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "code": "xxxxx",
  "username": "新用户名"
}
```

**参数信息**

| 参数名   | 示例 | 必要性 | 含义     | 类型   |
| -------- | ---- | ------ | -------- | ------ |
| username |      | 必须   | 新用户名 | string |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "******"
}
```

异常返回(ret≠0):

```json
{
  "ret": 3,
  "msg": "***"
}
```



### 查看错题本

#### 请求

**请求头**

```
 GET /api/user/wrong_que_book&pagenumber=1
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名     | 示例                                                | 必要性 | 含义           | 类型   |
| ---------- | --------------------------------------------------- | ------ | -------------- | ------ |
| pagenumber | 1                                                   | 必须   | 查找的页面     | string |
| type       | choice_question / cloze_question / reading_question | 可选   | 查找题目的类型 | string |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```python
{
  "list": [
    {
      "date": "2022-05-08T20:31:43.849349+08:00",
      "question": {
        "id": 9,
        "title": "yuedu3",
        "type": "reading_question"
      }
    },
    {
      "date": "2022-05-08T20:31:37.764765+08:00",
      "question": {
        "id": 5,
        "title": "wanxing2",
        "type": "cloze_question"
      }
    },
    {
      "date": "2022-05-08T20:28:53.850617+08:00",
      "question": {
        "id": 1,
        "title": "xuanze1",
        "type": "choice_question"
      }
    }
  ],
  "total": 3,
  "ret": 0,
  "msg": "Normal operation."
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义               | 类型info |
| ------ | ------- | ------ | ------------------ | -------- |
| ret    | 0       | 必有   | 是否正常返回       | int      |
| list   | [{},{}] | 必有   | 错题本列表信息     | list     |
| total  | 3       | 必有   | 错题表显示题目总数 | int      |

其中list是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名   | 示例                             | 必要性 | 含义       | 类型   |
| -------- | -------------------------------- | ------ | ---------- | ------ |
| date     | 2022-05-07T18:45:57.523873+08:00 | 必有   | 加入时间   | string |
| question | 题目详细信息                     | 必有   | 题目的信息 | list   |

其中 question 是包含题目多个信息的列表，每个题目信息的参数信息如下所示：

| 参数名 | 示例           | 必要性 | 含义       | 类型   |
| ------ | -------------- | ------ | ---------- | ------ |
| id     | 1              | 必有   | 题目的id   | int    |
| title  | wanxing1       | 必有   | 题目       | string |
| type   | CLOZE_QUE_NAME | 必有   | 题目的题型 | string |



### 向错题本添加错题

#### 请求

**请求头**

```
 POST /api/user/wrong_que_book?id=1
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型   |
| ------ | ---- | ------ | ------------ | ------ |
| id     | 1    | 必须   | 添加错题的id | string |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "Normal operation"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 删除错题本中的题

#### 请求

**请求头**

```
 DELETE /api/user/wrong_que_book?id=1
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型   |
| ------ | ---- | ------ | ------------ | ------ |
| id     | 1    | 必须   | 删除错题的id | string |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "Normal operation"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |

错误返回(ret=3):

```json
{
  "ret": 3,
  "msg": "错题本查询不到对应题目"
}
```



### 查看刷题记录

#### 请求

**请求头**

```
 GET /api/user/record?pagenumber=1&type=cloze_question 
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名     | 示例                                                | 必要性 | 含义                 | 类型   |
| ---------- | --------------------------------------------------- | ------ | -------------------- | ------ |
| pagenumber | 1                                                   | 必须   | 历史记录页面         | string |
| type       | choice_question / cloze_question / reading_question | 可选   | 查看的历史记录的题型 | string |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

```python
{
  "list": [
    {
      "date": "2022-05-08T20:51:41.735298+08:00",
      "question": {
        "id": 8,
        "title": "yuedu2",
        "type": "reading_question"
      }
    },
    {
      "date": "2022-05-08T20:51:36.033919+08:00",
      "question": {
        "id": 6,
        "title": "wanxing3",
        "type": "cloze_question"
      }
    },
    {
      "date": "2022-05-08T20:51:29.649893+08:00",
      "question": {
        "id": 5,
        "title": "wanxing2",
        "type": "cloze_question"
      }
    }
  ],
  "total": 3,
  "ret": 0,
  "msg": "Normal operation."
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义                 | 类型info |
| ------ | ------- | ------ | -------------------- | -------- |
| ret    | 0       | 必有   | 是否正常返回         | int      |
| list   | [{},{}] | 必有   | 错题本列表信息       | list     |
| total  | 3       | 必有   | 历史记录返回题目总数 | int      |

其中list是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名   | 示例                             | 必要性 | 含义       | 类型   |
| -------- | -------------------------------- | ------ | ---------- | ------ |
| date     | 2022-05-07T18:45:57.523873+08:00 | 必有   | 加入时间   | string |
| question | 题目详细信息                     | 必有   | 题目的信息 | list   |

其中question是包含题目多个信息的列表，每个题目信息的参数信息如下所示：

| 参数名 | 示例           | 必要性 | 含义       | 类型   |
| ------ | -------------- | ------ | ---------- | ------ |
| id     | 1              | 必有   | 题目的id   | int    |
| title  | wanxing1       | 必有   | 题目       | string |
| type   | cloze_question | 必有   | 题目的题型 | string |



### 删除单条历史记录

#### 请求

**请求头**

```
 DELETE /api/user/single_history?id=1&date=2022-05-10T13:12:04.317702+08:00
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例                             | 必要性 | 含义         | 类型info |
| ------ | -------------------------------- | ------ | ------------ | -------- |
| id     | 1                                | 必有   | 题目题号     | int      |
| date   | 2022-05-10T13:12:04.317702+08:00 | 必有   | 历史记录时间 | string   |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

```python
{
  "ret": 0,
  "msg": "Normal operation."
}
```



### 用户清空刷题记录

#### 请求

**请求头**

```
 DELETE /api/user/record
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

```json
{
  "ret": 0,
  "msg": "Normal operation."
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 查看做题详情

#### 请求

**请求头**

```
 GET /api/user/detail?id=1
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义                       | 类型   |
| ------ | ---- | ------ | -------------------------- | ------ |
| id     | 1    | 必须   | 该用户所查询的题目对应的id | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "id": 1,
  "title": "xuanze1",
  "text": null,
  "sub_que_num": 1,
  "sub_que": [
    {
        "number": 1,
        "stem": "qwer",
        "options": [
          "a",
          "b",
          "c",
          "d"
        ],
        "answer": "A",
      	"option": "A"
    },
  ],
  "ret": 0,
  "msg": "Normal operation."
}
```

**参数信息**

| 参数名      | 示例    | 必要性 | 含义                             | 类型info |
| ----------- | ------- | ------ | -------------------------------- | -------- |
| ret         | 0       | 必有   | 是否正常返回                     | int      |
| text        | " "     | 可选   | 阅读、完形的文章，选择题此项为空 | string   |
| sub_que_num | 4       | 必有   | 子题目数目                       | int      |
| sub_que     | [{},{}] | 必有   | 子题目的信息                     | list     |

其中sub_que是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名  | 示例                 | 必要性 | 含义         | 类型   |
| ------- | -------------------- | ------ | ------------ | ------ |
| number  | 1                    | 必有   | 子题目的题号 | int    |
| stem    | qwer                 | 必有   | 题干         | string |
| options | [“a”, “b”, “c”, “d”] | 必有   | 选项         | string |
| answer  | A                    | 必有   | 题目答案     | string |
| option  | A                    | 必有   | 用户选项     | string |

错误返回(ret=3):

```json
{
	"ret": 3,
	"msg": "查询不到该题目，可能被管理员删除了"
}
```





### 查看刷题统计

#### 请求

**请求头**

```
 GET /api/user/statistics
 Cookie: sessionid=<sessionid数值>
```

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义         | 类型info |
| ------ | ------- | ------ | ------------ | -------- |
| ret    | 0       | 必有   | 是否正常返回 | int      |
| list   | [{},{}] | 必有   | 列表信息     | list     |

其中list是包含题目多个信息的列表，每个题目信息的参数信息如下所示：

| 参数名        | 示例 | 必要性 | 含义           | 类型 |
| ------------- | ---- | ------ | -------------- | ---- |
| choice_num    | 1    | 必有   | 做过的单选数量 | int  |
| choice_right  | 1    | 必有   | 做对的单选数量 | int  |
| cloze_num     | 1    | 必有   | 做过的完型数量 | int  |
| cloze_right   | 1    | 必有   | 做对的完型数量 | int  |
| reading_num   | 1    | 必有   | 做过的阅读数量 | int  |
| reading_right | 1    | 必有   | 做对的阅读数量 | int  |



### 获取题目题面

用户既可以随机获取题目，也可指定获取某道题，指定获取只可用在错题本和刷题记录上

完型和阅读题每次获取一道题，选择每次获取十道题。

#### 请求

**请求头**

```
 GET /api/user/get_question?type=choice_question&id=1
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例                                                | 必要性 | 含义           | 类型   |
| ------ | --------------------------------------------------- | ------ | -------------- | ------ |
| type   | choice_question / cloze_question / reading_question | 必有   | 获取题目的类型 | string |
| id     | 2                                                   | 不必有 | 获取题目的ID   | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "id": 8,
  "title": "wanxing1",
  "text": "qwer",
  "sub_que_num": 1,
  "sub_que": [
    {
      "id": 6,
      "number": 1,
      "stem": null,
      "options": [
        "a",
        "b",
        "c",
        "d"
      ]
    }
  ],
  "flag": 0,
  "ret": 0,
  "msg": "Normal operation."
}
```

错误返回(ret>0):

```json
{
  "ret": 3,
  "msg": "哦吼，本题已经被管理员删除啦"
}
```

**参数信息**

| 参数名      | 示例    | 必要性 | 含义                                            | 类型info |
| ----------- | ------- | ------ | ----------------------------------------------- | -------- |
| ret         | 0       | 必有   | 是否正常返回                                    | int      |
| flag        | 0       | 必有   | 为0表示处于刷题库阶段   为1表示处于刷错题本阶段 | int      |
| text        | " "     | 可选   | 阅读、完形的文章，选择题此项为空                | string   |
| sub_que_num | 4       | 必有   | 子题目数目                                      | int      |
| sub_que     | [{},{}] | 必有   | 子题目的信息                                    | list     |

其中sub_que是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名  | 示例                                                         | 必要性 | 含义                       | 类型   |
| ------- | ------------------------------------------------------------ | ------ | -------------------------- | ------ |
| id      | 6                                                            | 必有   | 子题目的id                 | int    |
| "stem"  | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空 | string |
| number  | 1                                                            | 必有   | 子问题的题号               | int    |
| options | ["carefully","careful", "busily","busy"]                     | 必有   | 选项                       | list   |



### 获取题目答案

#### 请求

**请求头**

```
 POST /api/user/check_question
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例                                                | 必要性 | 含义           | 类型   |
| ------ | --------------------------------------------------- | ------ | -------------- | ------ |
| type   | choice_question / cloze_question / reading_question | 必有   | 获取题目的类型 | string |
| id     | 2                                                   | 必有   | 获取题目的ID   | string |
| data   | [{},{}]                                             | 必有   | 用户的作答信息 | list   |

其中 data 是包含多个用户提交信息的列表，每个提交信息的参数信息如下所示：

| 参数名 | 示例 | 必要性 | 含义                     | 类型   |
| ------ | ---- | ------ | ------------------------ | ------ |
| sub_id | 40   | 必有   | 子题目的id               | int    |
| submit | B    | 必有   | 用户在该子题目提交的选项 | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

正常返回(ret=0)

```python
{
  "sub_que": [
    {
      "number": 1,
      "answer": "A"
    },
    {
      "number": 2,
      "answer": "B"
    },
    {
      "number": 3,
      "answer": "C"
    },
    {
      "number": 4,
      "answer": "D"
    },
    {
      "number": 5,
      "answer": "C"
    }
  ],
  "ret": 0,
  "msg": "Normal operation."
}
```

**参数信息**

| 参数名  | 示例    | 必要性 | 含义             | 类型info |
| ------- | ------- | ------ | ---------------- | -------- |
| ret     | 0       | 必有   | 是否正常返回     | int      |
| sub_que | [{},{}] | 必有   | 子题目的答案列表 | list     |

其中 sub_que 是包含多个子题目答案的列表，每个子题目答案的参数信息如下所示：

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| number | 1    | 必有   | 子问题的题号 | int  |
| answer | C    | 必有   | 正确选项     | list |





### 查看题解

#### 请求

**请求头**

```
 GET /api/user/solution?id=123
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义     | 类型 |
| ------ | ---- | ------ | -------- | ---- |
| id     | 2    | 必有   | 大题的ID | int  |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```js
{
  "solution_num": 2,
  "solution": 
  [
      {
          "number": 1,
          "id": 111,
          "content": "题解内容",
          "likes": 3,
          "reports": 1,
          "approved": 0,
          "author_username":"小明",
          "author_solution_sum":10,
          "author_likes": 34,
          "author_reports": 2
      },
      {
          "number": 2,
          "id": 112,
          "content": "题解内容",
          "likes": 5,
          "reports": 11,
          "approved": 1,
          "author_username":"小红",
          "author_solution_sum":10,
          "author_likes": 15,
          "author_reports": 12
      }
  ]
  
}
```

**参数信息**

| 参数名       | 示例 | 必要性 | 含义                   | 类型 |
| ------------ | ---- | ------ | ---------------------- | ---- |
| solution_num |      | 必有   | 该大题所有题解的总数   | int  |
| solution     |      | 必有   | 题解信息字典组成的列表 | 数组 |

​	题解信息字典格式如下

| 参数名              | 示例    | 必要性 | 含义                                                     | 类型   |
| ------------------- | ------- | ------ | -------------------------------------------------------- | ------ |
| number              |         | 必有   | 该题解所属小题的序号                                     | int    |
| id                  |         | 必有   | 该题解的id                                               | int    |
| content             |         | 必有   | 该题解内容                                               | string |
| likes               |         | 必有   | 该题解点赞数                                             | int    |
| reports             |         | 必有   | 该题解举报数                                             | int    |
| approved            | 1或0或2 | 必有   | =1表示用户已经点赞过此题解，=2表示举报过此题解，=0则没有 | int    |
| author_username     |         | 必有   | 发布此题解的用户的用户名                                 | string |
| author_solution_sum |         | 必有   | 发布此题解的用户所发表的题解总数                         | int    |
| author_likes        |         | 必有   | 发布此题解的用户所发表题解被点赞的总数                   | int    |
| author_reports      |         | 必有   | 发布此题解的用户所发表题解被举报的总数                   | int    |



### 发表题解

#### 请求

**请求头**

```
 POST /api/user/solution
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```js
{
  "id": 1,
  "solution": "这个是题解内容"
}
```

**参数信息**

| 参数名   | 示例           | 必要性 | 含义       | 类型   |
| -------- | -------------- | ------ | ---------- | ------ |
| id       | 2              | 必有   | 子题目的ID | int    |
| solution | 这个是题解内容 | 必有   | 题解内容   | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 为题解点赞

#### 请求

**请求头**

```
 POST /api/user/solution_like
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```js
{
  "id": 1
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义   | 类型 |
| ------ | ---- | ------ | ------ | ---- |
| id     |      | 必有   | 题解id | int  |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "***"
}
```



### 举报题解

#### 请求

**请求头**

```
 POST /api/user/solution_report
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```js
{
  "id":1
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义   | 类型 |
| ------ | ---- | ------ | ------ | ---- |
| id     |      | 必有   | 题解id | int  |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "ret": 0,
  "msg": "***"
}
```



### 查看做题积分排名

前端需要提供页码，只需要按照返回的数据格式进行解读即可。

#### 请求

**请求头**

```
 GET /api/user/rank_que?pagenumber=1
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名     | 示例 | 必要性 | 含义       | 类型   |
| ---------- | ---- | ------ | ---------- | ------ |
| pagenumber | 1    | 必须   | 查找的页面 | string |

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "rank_que_list": [
    {
      "user_name": "eexx",
      "rank_question": "6"
    },
    {
      "user_name": "xxx",
      "rank_question": "0"
    }
  ],
  "page_all": "1",
  "ret ": "0",
  "msg": "Normal operation."
}
```



**参数信息**

| 参数名        | 示例    | 必要性 | 含义                     | 类型info |
| ------------- | ------- | ------ | ------------------------ | -------- |
| ret           | 0       | 必有   | 是否正常返回             | int      |
| rank_que_list | [{},{}] | 必有   | 返回每个用户的名称和积分 | list     |

其中 rank_que_list 是包含多个用户名称和获得做题积分的列表，且已经按照积分大小排序。每个子题目信息的参数信息如下所示：

| 参数名        | 示例 | 必要性 | 含义           | 类型   |
| ------------- | ---- | ------ | -------------- | ------ |
| user_name     | eexx | 必要   | 用户名         | string |
| rank_question | 6    | 必要   | 获得的做题积分 | int    |



### 查看题解积分排名

前端需要提供页码，只需要按照返回的数据格式进行解读即可。

#### 请求

**请求头**

```
 GET /api/user/rank_sol?pagenumber=1
 Cookie: sessionid=<sessionid数值>
```

**参数信息**

| 参数名     | 示例 | 必要性 | 含义       | 类型   |
| ---------- | ---- | ------ | ---------- | ------ |
| pagenumber | 1    | 必须   | 查找的页面 | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(ret=0):

```json
{
  "rank_sol_list": [
    {
      "user_name": "eexx",
      "rank_solution": "6"
    },
    {
      "user_name": "xxx",
      "rank_solution": "0"
    }
  ],
  "page_all": "1",
  "ret ": "0",
  "msg": "Normal operation."
}
```



**参数信息**

| 参数名        | 示例    | 必要性 | 含义                     | 类型info |
| ------------- | ------- | ------ | ------------------------ | -------- |
| ret           | 0       | 必有   | 是否正常返回             | int      |
| rank_sol_list | [{},{}] | 必有   | 返回每个用户的名称和积分 | list     |

其中 rank_sol_list 是包含多个用户名称和获得题解积分的列表，且已经按照积分大小排序。每个子题目信息的参数信息如下所示：

| 参数名        | 示例 | 必要性 | 含义           | 类型   |
| ------------- | ---- | ------ | -------------- | ------ |
| user_name     | eexx | 必要   | 用户名         | string |
| rank_solution | 6    | 必要   | 获得的题解积分 | int    |



### 查看公告

#### 请求

**请求头**

```
 GET /api/user/notice
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**参数信息**

| 参数名  | 示例  | 必要性 | 含义           | 类型info |
| ------- | ----- | ------ | -------------- | -------- |
| ret     | 0     | 必要   | 是否正常返回   | int      |
| content | hello | 必要   | 错题本列表信息 | string   |
| time    |       | 必要   | 公告设置时间   | string   |





------

## Reference:

We cannot generate this doc without exsiting help from project list below:

 [SE-BSsystem](https://github.com/HK-vv/SE-BSsystem/)

