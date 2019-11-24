# Copyright (c) 2014-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed in accordance with the terms specified in
# the LICENSE file found in the root directory of this source tree.

cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_LIST_DIR}/api.cmake")

locateSystemLibrary(
  NAME aws-sdk-cpp
  REQUIRED ${aws-sdk-cpp_REQUIRED}
  MAIN_HEADER "aws/core/Version.h" "aws/ec2/EC2Client.h" "aws/firehose/FirehoseClient.h" "aws/kinesis/KinesisClient.h "
  LIBRARIES "aws-cpp-sdk-core" "aws-cpp-sdk-ec2" "aws-cpp-sdk-firehose" "aws-cpp-sdk-kinesis" "aws-cpp-sdk-sts"
)
