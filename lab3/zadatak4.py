import sys
import re
import urllib.request
from collections import defaultdict


def load_website(url: str) -> str:
    website = urllib.request.urlopen(url)
    return website.read().decode("utf-8")


def parse_website(website: str, website_url) -> None:
    if website_url[-1] != "/":
        website_url += "/"
    href_re = re.compile(r"href=\"(.+?)\"")
    host_re = re.compile(r"https*:\/\/.+?\/")
    mail_re = re.compile(r"$.*@.*^")
    img_re = re.compile(r"<img.*src=\".*\".*>")
    hosts = defaultdict(lambda: 0)
    for href in href_re.findall(website):
        if match := host_re.match(href):
            hosts[match.group()] += 1
        else:
            hosts[website_url] += 1
    print(
        "Hosts and reference count:\n"
        + "\n".join([f"{k}: {v}" for k, v in hosts.items()])
    )
    print(f"E-mails: {' '.join(mail_re.findall(website))}")
    print(f"Number of img srcs: {len(img_re.findall(website))}")


def main():
    website = load_website(sys.argv[1])
    parse_website(website, sys.argv[1])


if __name__ == "__main__":
    main()