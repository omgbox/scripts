import subprocess
import time

# Define the paths and commands
vlc_path = r"C:\Program Files\VideoLAN\VLC\vlc.exe"  # Update this path to your VLC installation
# the IP of chromecast
chromecast_ip = "192.168.1.101"

# Display the menu
def display_menu():
    print("\nSelect an option:\n")
    print("1. Transcode media and stream to Chromecast")
    print("2. Exit")

# Get user input
def get_user_choice():
    return input("\nEnter your choice (1-2): ")

# Process the user's choice
def process_choice(choice, magnet_link):
    if choice == "1":
        print("\nStarting transcoding...\n")
        transcode_command = [
            vlc_path,
            magnet_link,
            "--intf", "dummy",  # Hide the transcoding VLC window
            ":sout=#transcode{vcodec=mp2v,vb=10800,scale=Auto,soverlay}:http{mux=ts,dst=:8080/play}",
            ":no-sout-all",
            ":sout-keep"
        ]
        transcode_process = subprocess.Popen(transcode_command)

        print("Waiting for 35 seconds to ensure transcoding has enough data...\n")
        time.sleep(35)

        print("Starting streaming to Chromecast...\n")
        stream_command = [
            vlc_path,
            "http://localhost:8080/play",
            "--sout", "#chromecast",
            "--sout-chromecast-ip", chromecast_ip
        ]
        subprocess.Popen(stream_command)
    elif choice == "2":
        print("\nExiting...\n")
    else:
        print("\nInvalid choice. Please enter a number between 1 and 2.\n")

# Main function
def main():
    magnet_link = input("Enter the magnet link for transcoding: ")
    while True:
        display_menu()
        choice = get_user_choice()
        process_choice(choice, magnet_link)
        if choice == "2":
            break

if __name__ == "__main__":
    main()

  # transcode remote MKV with internal subtitles to http and start a second vlc to chromecast https://localhost:8080/play
