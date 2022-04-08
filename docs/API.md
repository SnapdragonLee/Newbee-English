## 返回值(ret)规定

| ret值 | 含义            | 后续操作                 | 备注                       |
| ----- | --------------- | ------------------------ | -------------------------- |
| 0     | 正常返回        | 继续执行                 |                            |
| 1     | 一般错误        | 返回到执行前重新执行     | 权限不足、查询信息不存在等 |
| 2     | 请求无sessionid | 返回登录界面             | 所有接口均可能返回该值     |
| 3     | 其他错误        | 查看后台报错信息尝试修复 | 所有接口均可能返回该值     |



# 管理端

#### 登录

管理员使用该接口进行登录。前端发送的登录请求中包含用户名、密码。 后端接收后，对账号密码的正确性进行校验。 如果校验通过，服务端在响应消息头使用set_cookie 存入sessionid。

##### 请求

**请求头**

```
POST /api/admin/login
Content-Type: application/json
```

**消息体**

```
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

##### 响应

**响应头**

```
200 OK
Content-Type: application/json
set_cookie: sessionid=<sessionid数值>
```

**消息体**

正常返回(info==='Ok'):

```
{
  "info": 'Ok'
}
```

异常返回(info==='Error'):

```
{
"info":'Error'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型   |
| ------ | ---- | ------ | ------------ | :----- |
| info   | Ok   | 必有   | 是否正常返回 | string |



#### 登出

##### 请求

**请求头**

```
DELETE /api/admin/logout
Cookie: sessionid=<sessionid数值>
```

##### 响应

后端清除对应session，然后返回响应消息。

**响应头**

```
200 OK
Content-Type: application/json
Set-Cookie: sessionid=""
```

**消息体**

正常返回(info ===Ok):

```
{
  "info":'OK'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型   |
| ------ | ---- | ------ | ------------ | ------ |
| info   | OK   | 必有   | 是否正常返回 | string |



#### 查看用户信息

管理员查看用户信息。

##### 请求

**请求头**

```
GET /api/admin/manage_user
Cookie: sessionid=<sessionid数值>
```

##### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(info===Ok):

```
{
  "info": 'Ok',
  "list": { 
    "name": "小赵",
    "numm":"888",
    "numc":"777",
    "numr":"666"
  }
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义         | 类型info   |
| ------ | ------- | ------ | ------------ | ---------- |
| info   | OK      | 必有   | 是否正常返回 | string     |
| list   | [{},{}] | 必有   | 用户信息     | dictionary |

其中`list`中的参数信息如下所示：

| 参数名 | 示例 | 必要性 | 含义     | 类型   |
| ------ | ---- | ------ | -------- | ------ |
| name   | 小赵 | 必有   | 用户名   | string |
| numm   | 888  | 必有   | 单选数量 | string |
| numc   | 777  | 必有   | 完型数量 | string |
| numr   | 666  | 必有   | 阅读数量 | string |



#### 管理员删除用户

管理员删除用户

##### 请求

**请求头**

```
 DELETE /api/admin/manage_user
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员查看题目

##### 请求

**请求头**

```
 GET /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员上传题目

管理员上传题目

##### 请求

**请求头**

```
 POST /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员修改题目

##### 请求

**请求头**

```
 PUT /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员删除题目

##### 请求

**请求头**

```
 DELETE /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员查看题解

##### 请求

**请求头**

```
 GET /api/admin/que_solution
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员删除题解

##### 请求

**请求头**

```
 DELETE /api/admin/que_solution
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员查看公告

##### 请求

**请求头**

```
 GET /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员创建公告

##### 请求

**请求头**

```
 POST /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员修改公告

##### 请求

**请求头**

```
 PUT /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 管理员删除公告

##### 请求

**请求头**

```
 DELETE /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```





# 用户端

#### 用户登录

##### 请求

**请求头**

```
 POST /api/user/login
```

**响应头**

```
200 OK
Content-Type: application/json
set_cookie: sessionid=<sessionid数值>
```



#### 用户查看用户名

##### 请求

**请求头**

```
 GET /api/user/profile
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户修改用户名

##### 请求

**请求头**

```
 PUT /api/user/profile
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户查看错题本

##### 请求

**请求头**

```
 GET /api/user/wrong_que_book
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户向错题本添加错题

##### 请求

**请求头**

```
 POST /api/user/wrong_que_book
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户删除错题本中的题

##### 请求

**请求头**

```
 DELETE /api/user/wrong_que_book
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户查看刷题记录

##### 请求

**请求头**

```
 GET /api/user/record
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户查看刷题统计

##### 请求

**请求头**

```
 GET /api/user/statistics
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户清空刷题统计

##### 请求

**请求头**

```
 DELETE /api/user/statistics
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户获取题目题面

待定：用户既可以随机获取题目，也可指定获取某道题，“指定获取”或许可用在错题本和刷题记录上

##### 请求

**请求头**

```
 GET /api/user/get_question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户获取题目答案

##### 请求

**请求头**

```
 GET /api/user/check_question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户查看某道题的题解

##### 请求

**请求头**

```
 GET /api/user/que_solution
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户发表某道题的题解

##### 请求

**请求头**

```
 POST /api/user/que_solution
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户为某道题解点赞

##### 请求

**请求头**

```
 PATCH /api/user/que_soluton_like
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户举报某个题解

##### 请求

**请求头**

```
 PATCH /api/user/que_soluton_report
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户查看排名

前端需要提供参数供后端查询，参数包括题目类型

##### 请求

**请求头**

```
 GET /api/user/rank
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 用户查看公告

##### 请求

**请求头**

```
 GET /api/user/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```

