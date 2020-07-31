#
# Copyright:: Chef Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "libxml2"
default_version "2.9.10"

license "MIT"
license_file "COPYING"
skip_transitive_dependency_licensing true

dependency "zlib"
dependency "liblzma"
dependency "config_guess"

version("2.9.10") { source sha256: "aafee193ffb8fe0c82d4afef6ef91972cbaf5feea100edc2f262750611b4be1f" }
version("2.9.9") { source sha256: "94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871" }

source url: "ftp://xmlsoft.org/libxml2/libxml2-#{version}.tar.gz"

relative_path "libxml2-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  configure_command = [
    "--with-zlib=#{install_dir}/embedded",
    "--with-lzma=#{install_dir}/embedded",
    "--without-iconv",
    "--without-python",
    "--without-icu",
    "--without-debug",
  ]

  update_config_guess

  configure(*configure_command, env: env)

  make "-j #{workers}", env: env
  make "install", env: env
end
