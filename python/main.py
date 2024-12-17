from api import server_with_ip

if __name__ == "__main__":
    server = server_with_ip("0.0.0.0", 25565)
    server.run()
