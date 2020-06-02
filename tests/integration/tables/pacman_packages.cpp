/**
 *  Copyright (c) 2020-present, Anatol Pomazau.
 *  All rights reserved.
 *
 *  This source code is licensed in accordance with the terms specified in
 *  the LICENSE file found in the root directory of this source tree.
 */

// Sanity check integration test for pacman_packages
// Spec file: specs/linux/pacman_packages.table

#include <osquery/tests/integration/tables/helper.h>

#include <osquery/logger/logger.h>

namespace osquery {
namespace table_tests {

class PacmanPackages : public testing::Test {
 protected:
  void SetUp() override {
    setUpEnvironment();
  }
};

TEST_F(PacmanPackages, test_sanity) {
  QueryData rows = execute_query("select * from pacman_packages");
  if (rows.size() > 0) {
    ValidationMap row_map = {{"name", NonEmptyString},
                             {"version", NonEmptyString},
                             {"origin", NormalType},
                             {"url", NormalType},
                             {"md5sum", MD5},
                             {"sha256sum", SHA256},
                             {"arch", NonEmptyString},
                             {"packager", NonEmptyString},
                             {"build_date", IntType},
                             {"install_date", IntType},
                             {"package_size", IntType},
                             {"install_size", IntType},
                           };
    validate_rows(rows, row_map);

    auto all_packages = std::unordered_set<std::string>{};
    for (const auto& row : rows) {
      auto pckg_name = row.at("name");
      all_packages.insert(pckg_name);
    }

    ASSERT_EQ(all_packages.count("linux"), 1u);

  } else {
    LOG(WARNING) << "Empty results of query from 'pacman_packages', assume there "
                    "is no linux in the system";
  }
}

} // namespace table_tests
} // namespace osquery
