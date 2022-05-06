[TOC]



# API 参考文档

本文档为 Newbee-English API 文档，参考请参见 Reference.



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
    "msg": '******'
}
```

异常返回(ret≠0):

```json
{
	"ret":3,
    'msg': '用户名或密码错误'
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
    "msg": '******',
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 查看管理员用户名

此api可返回管理员的昵称

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
  "msg": '******',
  "name":'小赵'
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
GET /api/admin/list_user?pagenumber=2&pagesize=12
Cookie: sessionid=<sessionid数值>
```



**参数信息**

| 参数名     | 示例 | 必要性 | 含义               | 类型 |
| ---------- | ---- | ------ | ------------------ | ---- |
| pagenumber | 2    | 必有   | 获取第几页的信息   | int  |
| pagesize   | 12   | 必有   | 每页列出的账号数量 | int  |



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
    "msg": '******',
  "list": [{ 
    "name": "小赵",
    "numm":"888",
    "numc":"777",
    "numr":"666"
  },
  {
  "name": "小李",
  "numm":"888",
  "numc":"999",
  "numr":"555"
  }]，
  ”total":32
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义           | 类型info |
| ------ | ------- | ------ | -------------- | -------- |
| ret    | 0       | 必有   | 是否正常返回   | int      |
| list   | [{},{}] | 必有   | 所有用户的信息 | list     |
| total  | 32      | 必有   | 所有用户的数量 | int      |

其中 `list` 是包含多个查找结果的列表，每个结果的参数信息如下所示：

| 参数名 | 示例 | 必要性 | 含义     | 类型   |
| ------ | ---- | ------ | -------- | ------ |
| name   | 小赵 | 必有   | 用户名   | string |
| numm   | 888  | 必有   | 单选数量 | string |
| numc   | 777  | 必有   | 完型数量 | string |
| numr   | 666  | 必有   | 阅读数量 | string |



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
    "msg": '******',
  "list": [{ 
    "name": "test",
    "numm":"888",
    "numc":"777",
    "numr":"666"
  },
  {
  "name": "test",
  "numm":"888",
  "numc":"999",
  "numr":"555"
  }]，
  ”total":32
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义               | 类型info |
| ------ | ------- | ------ | ------------------ | -------- |
| ret    | 0       | 必有   | 是否正常返回       | int      |
| list   | [{},{}] | 必有   | 搜索到的用户的信息 | list     |
| total  | 32      | 必有   | 搜索到的用户的数量 | int      |

其中 `list` 是包含多个查找结果的列表，每个结果的参数信息如下所示：

| 参数名 | 示例 | 必要性 | 含义     | 类型   |
| ------ | ---- | ------ | -------- | ------ |
| name   | test | 必有   | 用户名   | string |
| numm   | 888  | 必有   | 单选数量 | string |
| numc   | 777  | 必有   | 完型数量 | string |
| numr   | 666  | 必有   | 阅读数量 | string |



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
    ”userid“：['1'，'22']
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
    "msg": '******',
}
```

异常返回 (ret ≠ 0):

```json
{
	"ret":3，
    "msg": '******'
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
    "msg": '******',
  "list": [{ 
    "id": 123,
    "title": "Lily was so ___looking at the picture that she forgot the time",
    "sub_que_num":"2",
     "has_bad_solution": 1
  },
  {
    "id": 124,
    "title": "Lily was so ___looking at the picture that she forgot the time",
    "sub_que_num":"3",
     "has_bad_solution": 0 
  }]，
  ”total":32
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
  "msg": '******',
  "title":"",
  "text":"",
  "sub_que_num":2，
  "sub_que":[
      {
    	 "id": 123, 
          "stem":"Lily was so ___looking at the picture that she forgot the time.",
    	  "number": 1,
          "options":[
            "carefully",
            "careful",
            "busily",
            "busy"
          ],
          "answer": "B"，
		  "has_bad_solution":1
      },
      {
          "id": 124, 
          "stem":"Lily was so ___looking at the picture that she forgot the time.",
          "number": 2,
          "options":[
            "carefully",
            "careful",
            "busily",
            "busy"
          ],
          "answer": "B"，
          "has_bad_solution":0
      }
	]
}
```

错误返回(ret>0):

```json
{
	"ret":3，
    "msg": '******'
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

其中sub_que是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名           | 示例                                                         | 必要性 | 含义                                   | 类型   |
| ---------------- | ------------------------------------------------------------ | ------ | -------------------------------------- | ------ |
| id               |                                                              | 必有   | 子题目的id                             | int    |
| "stem"           | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空             | string |
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
  "text":"文章在这里",
  "sub_que_num":2,
  "sub_que":[
  {
      "stem":"Lily was so ___looking at the picture that she forgot the time.",
      "number": 1,
      "options":[
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"
  },
  {
      "stem":"Lily was so ___looking at the picture that she forgot the time.",
      "number": 2,
      "options":[
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

其中sub_que是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

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
    "msg": '******',
}
```

异常返回(ret≠0):

```json
{
	"ret": 3，
    "msg": '******'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 修改题目

管理员可通过此api修改题目

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
  "text":"修改后的文章",
  "sub_que_num":2,
  "sub_que":[
  {
      "stem":"修改后的第一题第1小题",
      "number": 1,
      "options":[
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"
  },
  {
      "stem":"修改后的第一题第2小题.",
      "number": 2,
      "options":[
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

其中sub_que是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

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
    "msg": '******',
}
```

异常返回(ret ≠ 0):

```json
{
	"ret": 3，
    "msg": '******'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 删除题目

管理员可通过此api删除题目

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
  "msg": '******',
}
```

异常返回(ret ≠ 0):

```json
{
	"ret":3，
    "msg": '******'
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
    "msg": '******',
 	"has_bad_solution": 1
}
```

异常返回(ret ≠ 0):

```json
{
	"ret":3,
    "msg": '******'
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
 	'solutions':[
         {
              'id': 123,
              'content': ,
              'likes': 4,
              'reports': 2,
              'bad_solution': 0
		},
        {
              'id': 124,
              'content': ,
              'likes': 1,
              'reports': 8,
              'bad_solution': 1
		},
    ],
 	'total': 2
}
```

异常返回(ret ≠ 0):

```json
{
	"ret":3,
    "msg": '******'
}
```

**参数信息**

| 参数名    | 示例 | 必要性 | 含义             | 类型 |
| --------- | ---- | ------ | ---------------- | ---- |
| ret       | 0    | 必有   | 是否正常返回     | int  |
| solutions |      | 必有   | 题解字典的列表   |      |
| total     |      | 必有   | 该小题的题解总数 | int  |

solutions结构如下

| 参数名       | 示例 | 必要性 | 含义                                       | 类型   |
| ------------ | ---- | ------ | ------------------------------------------ | ------ |
| id           |      | 必有   | 题解id                                     | int    |
| content      |      | 必有   | 题解内容                                   | string |
| likes        |      | 必有   | 该题解点赞数                               | int    |
| reports      |      | 必有   | 该题解举报数                               | int    |
| bad_solution |      | 必有   | =1表示该题解被举报比例过大，需要管理员审查 | int    |



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
  "msg": '******'
}
```

异常返回(ret≠0):

```json
{
	"ret":3，
    "msg": '******'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | :--- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



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
  ret:0,
  "msg": '******',
  "content" : "welcome to NewBee English",
    "time": "2022-05-07 00:26:35"
}
```

异常返回(ret ≠ 0):

```json
{
	"ret": 3，
    "msg": '******'
}
```

**参数信息**

| 参数名  | 示例                  | 必要性 | 含义         | 类型   |
| ------- | --------------------- | ------ | ------------ | ------ |
| ret     | 1                     | 必有   | 是否正常返回 | int    |
| content | welcom to..           | 必有   | 公告内容     | string |
| time    | "2022-05-07 00:26:35" | 必有   | 发布时间     | string |



### 修改公告

#### 请求

**请求头**

```
 POST /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "content" : "welcome to NewBee English"
}
```

**参数信息**

| 参数名  | 示例        | 必要性 | 含义     | 类型   |
| ------- | ----------- | ------ | -------- | ------ |
| content | welcom to.. | 必有   | 公告内容 | string |



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
  "msg": '******'
}
```

异常返回(ret≠0):

```json
{
	"ret": 3，
    "msg": '******'
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
  "code": xxxxx,
    "username":"微信昵称"
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
  "msg": '******'
}
```

异常返回(ret≠0):

```json
{
  "ret": 3
  "msg": '获取openid失败'
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
  "username":"用户名",
  "msg": '******'
}
```

异常返回(ret≠0):

```json
{
  "ret": 3
  "msg": '***'
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
  "code": xxxxx,
    "username":"新用户名"
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
  "msg": '******'
}
```

异常返回(ret≠0):

```json
{
	"ret": 3，
    "msg": '******'
}
```



### 查看错题本

#### 请求

**请求头**

```
 GET /api/user/wrong_que_book
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 向错题本添加错题

#### 请求

**请求头**

```
 POST /api/user/wrong_que_book
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 删除错题本中的题

#### 请求

**请求头**

```
 DELETE /api/user/wrong_que_book
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 查看刷题记录

#### 请求

**请求头**

```
 GET /api/user/record
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
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



### 用户清空刷题统计

#### 请求

**请求头**

```
 DELETE /api/user/statistics
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 获取题目题面

用户既可以随机获取题目，也可指定获取某道题，指定获取只可用在错题本和刷题记录上

完型和阅读题每次获取一道题，选择每次获取十道题

#### 请求

**请求头**

```
 GET /api/user/get_question?type=CHOICE_QUE_NAME&id=1
 Cookie: sessionid=<sessionid数值>
```



**参数信息**

| 参数名 | 示例                                                | 必要性 | 含义           | 类型   |
| ------ | --------------------------------------------------- | ------ | -------------- | ------ |
| type   | CHOICE_QUE_NAME   CLOZE_QUE_NAME   READING_QUE_NAME | 必有   | 获取题目的类型 | string |
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
  "ret": 0,
  "msg": '******',
  "title":"",
  "text":"",
  "sub_que_num":2，
  "sub_que":[
      {
    	 "id": 123, 
          "stem":"Lily was so ___looking at the picture that she forgot the time.",
    	  "number": 1,
          "options":[
            "carefully",
            "careful",
            "busily",
            "busy"
          ]
      },
      {
          "id": 124, 
          "stem":"Lily was so ___looking at the picture that she forgot the time.",
          "number": 2,
          "options":[
            "carefully",
            "careful",
            "busily",
            "busy"
          ]
      }
	]
}
```

错误返回(ret>0):

```json
{
	"ret":3，
    "msg": '哦吼，本题已经被管理员删除啦'
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

| 参数名     | 示例                                                         | 必要性 | 含义                       | 类型   |
| ---------- | ------------------------------------------------------------ | ------ | -------------------------- | ------ |
| id         |                                                              | 必有   | 子题目的id                 | int    |
| "stem"     | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空 | string |
| number     | 1                                                            | 必有   | 子问题的题号               | int    |
| options    | ["carefully","careful", "busily","busy"]                     | 必有   | 选项                       | list   |
| answer     | "B"                                                          | 必有   | 答案                       | string |
| answer key | ["认真审题"，"站在父亲的角度来就可以更好的理解第二小题"]     | 可选   | 子题目的题解               | list   |







### 获取题目答案

#### 请求

**请求头**

```
 GET /api/user/check_question
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 查看题解

#### 请求

**请求头**

```
 GET /api/user/solution
 Cookie: sessionid=<sessionid数值>
```

#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 发表题解

#### 请求

**请求头**

```
 POST /api/user/solution
 Cookie: sessionid=<sessionid数值>
```



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



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 举报题解

#### 请求

**请求头**

```
 POST /api/user/solution_report
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



### 查看排名

前端需要提供参数供后端查询，参数包括题目类型

#### 请求

**请求头**

```
 GET /api/user/rank
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



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







------

## Reference:

We cannot generate this doc without exsiting help from project list below:

 [SE-BSsystem](https://github.com/HK-vv/SE-BSsystem/)

