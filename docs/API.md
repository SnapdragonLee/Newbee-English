[TOC]



# API 参考文档

本文档为 Newbee-English API 文档，参考请参见 Reference.



## 全局设置

### 返回值设置(ret)

| ret值 | 含义                    | 后续操作                                      | 备注                       |
| ----- | ----------------------- | --------------------------------------------- | -------------------------- |
| 0     | 正常                    | 继续执行                                      |                            |
| 1     | 一般错误                | 返回到执行前重新执行(lxl：我认为这里有点问题) | 权限不足、查询信息不存在等 |
| 2     | 请求无sessionid，未登录 | 返回登录界面                                  | 所有接口均可能返回该值     |





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
  "ret": '0'
}
```

异常返回(ret≠0):

```json
{
"ret":'1'
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
  "ret": '0'
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
POST /api/admin/getname
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
  "ret": '0'
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
GET /api/admin/manage_user?pagenumber=2&pagesize=12
Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "pagenumber" : "2",
  "pagesize" : "12"
}
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
  "ret": '0',
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
GET /api/api_search?name=test&pagesize=12&pagenumber=1
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
  "ret": '0',
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
 DELETE /api/admin/manage_user?userid=1&userid=22
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
  "ret": 0
}
```

异常返回 (ret ≠ 0):

```json
{
"ret":'1'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | :--- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 创建用户

管理员可根据此api创建用户

后端应做用户名重复检查。

#### 请求

**请求头**

```
PUT /api/admin/user_account
Cookie: sessionid=<sessionid数值>
Content-Type: application/json
```

**消息体**

```json
{
  "username" : "小王"
  "userpwd" : "123456"
}
```

**参数信息**

| 参数名   | 示例   | 必要性 | 含义               | 类型   |
| -------- | ------ | ------ | ------------------ | ------ |
| username | 小王   | 必有   | 创建账户时的用户名 | string |
| userpwd  | 123456 | 必有   | 创建账户时的密码   | string |



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
  "ret": 0
}
```

异常返回(ret≠0):

```json
{
"ret":'1'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 查看题目列表

#### 请求

**请求头**

```
 GET /api/admin/question?pagenumber=2&pagesize=12&type=multiple
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "pagenumber" : "2",
  "pagesize" : "12",
  "type":"multiple"
}
```

**参数信息**

| 参数名     | 示例     | 必要性 | 含义               | 类型   |
| ---------- | -------- | ------ | ------------------ | ------ |
| pagenumber | 2        | 必有   | 获取第几页的信息   | int    |
| pagesize   | 12       | 必有   | 每页列出的题目数量 | int    |
| type       | multiple | 必有   | 要查看题目的类型   | string |



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
  "ret": '0',
  "list": [{ 
    "text": "Lily was so ___looking at the picture that she forgot the time",
    "sub_que_num":"2",
  },
  {
    "text": "Lily was so ___looking at the picture that she forgot the time",
    "sub_que_num":"3",
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

| 参数名      | 示例                                                         | 必要性 | 含义                                      | 类型   |
| ----------- | ------------------------------------------------------------ | ------ | ----------------------------------------- | ------ |
| text        | Lily was so ___looking at the picture that she forgot the time | 必有   | 阅读/完型文章第一句话或单选子题目第一句话 | string |
| sub_que_num | 2                                                            | 必有   | 所含小题数量                              | int    |



### 查看题目信息

#### 请求

**请求头**

```
 POST /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "ID" : "2",
}
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
  "ret": '0',
   "text":"",
  "sub_que_num":2，
  sub_que[
  {
      "stem":"Lily was so ___looking at the picture that she forgot the time."
      "options":[
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"，
      answer key:["这个题的关键在于认真审题"，"站在父亲的角度来就可以更好的理解本题"]
  },
  {
      "stem":"Lily was so ___looking at the picture that she forgot the time."
      "options":[
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"，
      answer key:["这个题的关键在于认真审题"，"站在父亲的角度来就可以更好的理解本题"]
  }，
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
| "stem"     | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空 | string |
| options    | ["carefully","careful", "busily","busy"]                     | 必有   | 选项                       | list   |
| answer     | "B"                                                          | 必有   | 答案                       | string |
| answer key | ["认真审题"，"站在父亲的角度来就可以更好的理解第二小题"]     | 可选   | 子题目的题解               | list   |



### 上传题目

#### 请求

**请求头**

```
 POST /api/admin/question
 Cookie: sessionid=<sessionid数值>
 Content-Type: application/json
```

**消息体**

```json
{
  "type": "multiple",
  "text":"",
  "sub_que_num":2，
  sub_que[
  {
      "stem":"Lily was so ___looking at the picture that she forgot the time."
      "options":[
        "carefully",
        "careful",
        "busily",
        "busy"
      ],
      "answer": "B"
  },
  {
      "stem":"Lily was so ___looking at the picture that she forgot the time."
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

| 参数名      | 示例                                          | 必要性 | 含义                             | 类型   |
| ----------- | --------------------------------------------- | ------ | -------------------------------- | ------ |
| type        | "multiple" / "cloze" / "readingcomprehension" | 必有   | 题目类型                         | string |
| text        | " "                                           | 可选   | 阅读、完形的文章，选择题此项为空 | string |
| sub_que_num | 4                                             | 必有   | 子题目数目                       | int    |
| sub_que     | [{},{}]                                       | 必有   | 子题目的信息                     | list   |

其中sub_que是包含多个子题目信息的列表，每个子题目信息的参数信息如下所示：

| 参数名  | 示例                                                         | 必要性 | 含义                       | 类型   |
| ------- | ------------------------------------------------------------ | ------ | -------------------------- | ------ |
| "stem"  | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空 | string |
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
  "ret": 0
}
```

异常返回(ret≠0):

```json
{
"ret":'1'
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
POST /api/admin/
Cookie: sessionid=<sessionid数值>
Content-Type: application/json
```

**消息体**

```json
{
  "problemid": 1,
  "newdata": {  
      text:" "
      sub_que[
          {
              "stem":"Lily was so ___looking at the picture that she forgot the time."
              "options":[
                "carefully",
                "careful",
                "busily",
                "busy"
              ],
              "answer": "B"
          },
          {
              "stem":"Lily was so ___looking at the picture that she forgot the time."
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

| 参数名    | 示例 | 必要性 | 含义           | 类型       |
| --------- | ---- | ------ | -------------- | ---------- |
| problemid | 1    | 必有   | 题目id         | int        |
| newdata   | { }  | 必有   | 需要修改的信息 | dictionary |

其中`newdata`中的参数信息如下所示：

| 参数名  | 示例    | 必要性 | 含义                             | 类型   |
| ------- | ------- | ------ | -------------------------------- | ------ |
| text    | ' '     | 可选   | 阅读、完形的文章，选择题此项为空 | string |
| sub_que | [{},{}] | 可选   | 子题目的信息                     | list   |

其中`sub_que`中的参数信息如下所示：

| 参数名  | 示例                                                         | 必要性 | 含义                       | 类型   |
| ------- | ------------------------------------------------------------ | ------ | -------------------------- | ------ |
| "stem"  | Lily was so ___looking at the picture that she forgot the time. | 可选   | 子题目的题面，完型此项为空 | string |
| options | ["carefully","careful", "busily","busy"]                     | 可选   | 选项                       | list   |
| answer  | "B"                                                          | 可选   | 答案                       | string |



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
  "ret": 0
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 1
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
DELETE /api/admin/question?question=11&question=21
Cookie: sessionid=<sessionid数值>
Content-Type: application/json
```

**消息体**

```json
{
  "questionid": [
    11,
    21
  ]
}
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
  "ret": 0
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 1
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型 |
| ------ | ---- | ------ | ------------ | ---- |
| ret    | 0    | 必有   | 是否正常返回 | int  |



### 删除题解

#### 请求

**请求头**

```
 DELETE /api/admin/que_solution
 Cookie: sessionid=<sessionid数值>
```

**消息体**

```json
{
  "id" : "3"
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义           | 类型   |
| ------ | ---- | ------ | -------------- | ------ |
| id     | 3    | 必有   | 被删除的题解ID | string |



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

正常返回(ret=0):

```json
{
  "ret": 0
}
```

异常返回(ret≠0):

```json
{
"ret":'1'
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
 POST /api/admin/notice
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
  ret:0
  "ancontent" : "welcome to NewBee English"
}
```

异常返回(ret ≠ 0):

```json
{
  "ret": 1
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
  "ancontent" : "welcome to NewBee English"
  "antime": { 
    "year": "2022",
    "month":"5",
    "day":"9",
    "hour":"14"
    "min":"23",
    "sec":"25"
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
  "ret": 0
}
```

异常返回(ret≠0):

```json
{
  "ret":'1'
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
  "code": xxxxx
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义                   | 类型   |
| ------ | ---- | ------ | ---------------------- | ------ |
| code   |      | 必须   | 小程序前端发过来的code | string |

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
  "ret": 0
}
```

异常返回(ret≠0):

```json
{
  "ret":'2'
}
```



### 查看用户名(lxl:这个名字应该写具体一些，可能你想描述的是昵称)

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



### 修改用户名(lxl:和上面相同的问题)

#### 请求

**请求头**

```
 PUT /api/user/profile
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
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

待定：用户既可以随机获取题目，也可指定获取某道题，“指定获取”或许可用在错题本和刷题记录上

#### 请求

**请求头**

```
 GET /api/user/get_question
 Cookie: sessionid=<sessionid数值>
```



#### 响应

**响应头**

```
200 OK
Content-Type: application/json
```



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
 GET /api/user/que_solution
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
 POST /api/user/que_solution
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
 PATCH /api/user/que_soluton_like
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
 PATCH /api/user/que_soluton_report
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

