from space import SpacePy
from sopsy import Sops, SopsyError
from pathlib import Path
import yaml

@SpacePy
def main(logger):
    if not Path(".sops.yaml").exists():
        logger.error("No .sops.yaml file found.")
        return

    secrets = Path(".sops.yaml").read_text()
    try:
        secrets = yaml.safe_load(secrets)
    except yaml.YAMLError as e:
        logger.error(f"Failed to parse .sops.yaml: {e}")
        return

    if "secrets" not in secrets:
        logger.error("No secrets key found in .sops.yaml.")
        return
    secrets = secrets["secrets"]

    for secret in secrets:
        if not Path(secret).exists():
            logger.error(f"Secret file {secret} does not exist.")
            continue

        try:
            logger.log(f"Decrypting secret {secret}.")
            sops = Sops(Path(secret), in_place=True)
            sops.decrypt()
            logger.log("Decryption successful.")
        except SopsyError as e:
            logger.error(f"Failed to decrypt secret: {e}")
        except Exception as e:
            logger.error(f"An unexpected error occurred: {e}")