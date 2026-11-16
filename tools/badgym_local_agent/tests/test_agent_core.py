import os
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from badgym_local_agent import agent_core as core


class AgentCoreTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.env = patch.dict(os.environ, {"BADGYM_PROJECT_ROOT": str(self.root)}, clear=False)
        self.env.start()

    def tearDown(self):
        self.env.stop()
        self.temp.cleanup()

    def test_rejects_path_traversal(self):
        with self.assertRaises(core.AgentError):
            core.resolve_project_path("../outside.txt")

    def test_rejects_protected_git_path(self):
        with self.assertRaises(core.AgentError):
            core.resolve_project_path(".git/config")

    def test_write_scope_is_limited(self):
        with self.assertRaises(core.AgentError):
            core.resolve_project_path("android/app/build.gradle", write=True)

    def test_tailnet_ip_and_port_validation(self):
        self.assertEqual(core.validate_tailnet_endpoint("100.123.18.54", 37337), "100.123.18.54:37337")
        with self.assertRaises(core.AgentError):
            core.validate_tailnet_endpoint("192.168.1.2", 37337)
        with self.assertRaises(core.AgentError):
            core.validate_tailnet_endpoint("100.123.18.54", 5555)

    def test_write_requires_feature_flag_and_approval(self):
        (self.root / "lib").mkdir()
        with patch.dict(os.environ, {"BADGYM_AGENT_ENABLE_WRITES": "0"}):
            with self.assertRaises(core.AgentError):
                core.write_project_file("lib/a.dart", "void main() {}", "MISSING", True)

    def test_write_checks_expected_hash(self):
        (self.root / "lib").mkdir()
        (self.root / "lib/a.dart").write_text("old", encoding="utf-8")
        with patch.dict(os.environ, {"BADGYM_AGENT_ENABLE_WRITES": "1"}):
            with self.assertRaises(core.AgentError):
                core.write_project_file("lib/a.dart", "new", "wrong-hash", True)


if __name__ == "__main__":
    unittest.main()
