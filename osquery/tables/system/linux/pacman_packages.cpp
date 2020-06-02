/**
 *  Copyright (c) 2020-present, Anatol Pomazau.
 *  All rights reserved.
 *
 *  This source code is licensed in accordance with the terms specified in
 *  the LICENSE file found in the root directory of this source tree.
 */

#include <alpm.h>

#include <osquery/core/tables.h>
#include <osquery/filesystem/filesystem.h>
#include <osquery/logger/logger.h>
#include <osquery/sql/dynamic_table_row.h>

namespace osquery {
namespace tables {

static const std::string kPacmanRoot{"/"};
static const std::string kPacmanDbPath{"/var/lib/pacman"};

const char* pacmanPackageOrigin(alpm_pkgfrom_t origin) {
  switch(origin) {
    case ALPM_PKG_FROM_FILE:
      return "file";
    case ALPM_PKG_FROM_LOCALDB:
      return "localdb";
    case ALPM_PKG_FROM_SYNCDB:
      return "syncdb";
    default:
      return "";
  }
}

std::string extractText(const char *val) {
  std::string ret;
  if (val != nullptr) {
    ret = TEXT(val);
  }

  return ret;
}

void extractPacmanPackageInfo(alpm_pkg_t* pkg, QueryData& results) {
  Row r;

  r["name"] = TEXT(alpm_pkg_get_name(pkg));
  r["version"] = TEXT(alpm_pkg_get_version(pkg));
  r["origin"] = TEXT(pacmanPackageOrigin(alpm_pkg_get_origin(pkg)));
  r["url"] = TEXT(alpm_pkg_get_url(pkg));
  r["md5sum"] = extractText(alpm_pkg_get_md5sum(pkg));
  r["sha256sum"] = extractText(alpm_pkg_get_sha256sum(pkg));
  r["arch"] = TEXT(alpm_pkg_get_arch(pkg));
  r["packager"] = TEXT(alpm_pkg_get_packager(pkg));
  r["build_date"] = INTEGER(alpm_pkg_get_builddate(pkg));
  r["install_date"] = INTEGER(alpm_pkg_get_installdate(pkg));
  r["package_size"] = BIGINT(alpm_pkg_get_size(pkg));
  r["install_size"] = BIGINT(alpm_pkg_get_isize(pkg));

  results.push_back(r);
}

QueryData genPacmanPackages(QueryContext& context) {
  QueryData results;

  if (!osquery::isDirectory(kPacmanDbPath)) {
    TLOG << "Cannot find Pacman database: " << kPacmanDbPath;
    return results;
  }

  auto dropper = DropPrivileges::get();
  dropper->dropTo("nobody");

  alpm_errno_t err;
  alpm_handle_t *handle = alpm_initialize(kPacmanRoot.c_str(), kPacmanDbPath.c_str(), &err);
  if (!handle) {
    TLOG << "Cannot initialize Pacman ALPM library: " << alpm_strerror(err);
    return results;
  }
  alpm_db_t *db_local = alpm_get_localdb(handle);
  if (!db_local) {
    TLOG << "Cannot read Pacman local database: " << alpm_strerror(alpm_errno(handle));
    return results;
  }

  for (alpm_list_t *j = alpm_db_get_pkgcache(db_local); j; j = alpm_list_next(j)) {
    alpm_pkg_t *pkg = (alpm_pkg_t *)j->data;
    extractPacmanPackageInfo(pkg, results);
  }

  return results;
}
} // namespace tables
} // namespace osquery
