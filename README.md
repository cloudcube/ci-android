# ci-android

一个基于 [Docker](https://www.docker.com/) 的 [Android](http://www.android.com/) 编译环境镜像，已安装了JDK，Android SDK，可用于持续集成。

[![Build Status](https://api.travis-ci.org/lijy91/ci-android.svg?branch=master)](https://travis-ci.org/lijy91/ci-android)

## 应用于 [DaoCloud CI](https://www.daocloud.io/)
在项目根目录创建一个 daocloud.yml 文件来开启你的持续集成服务。

```yml
image: daocloud.io/lijy91/ci-android

script:
    - ./gradlew app:assembleDebug --debug
```

## 已安装环境
- [x] Oracle Java JDK 7 (7u79)
- [x] Oracle Java JDK 8 (8u66)
- [x] Android SDK (r24.4.1)
- [ ] ~~Android NDK（安装NDK会造成构建时间过长和镜像过大问题）~~

## License

    Copyright (C) 2015 JianyingLi <lijy91@foxmail.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
