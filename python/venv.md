1. 创建虚拟环境

   ```shell
   $ python -m venv venv_dir  # 创建虚拟环境venv_dir， 会自动生成venv_dir文件夹
   ```

2. 激活虚拟环境

   ```shell
   $ cd venv_dir/
   $ ./Scripts/activate
   $ soucre ./bin/activate  # linux系统
   $ pip install package
   ```

   激活环境后所有的操作都在该虚拟环境中进行，不会到全局的python环境和其它python虚拟环境。

3. 退出虚////拟环境

   ```shell
   $ ./Scripts/deactivate
   ```

4. 删除虚拟环境

   ```shell
   $ rm -rf venv_dir
   ```

   删除虚拟环境目录即可删除虚拟环境（已安装的python包都会被删除）