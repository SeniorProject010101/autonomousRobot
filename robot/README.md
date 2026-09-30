This is is going to have the core connection and the hardware tools like its brain!


Got any questions? Sure, we got many too. 

## Running it with Docker

We run everything in a tiny ROS 2 container so the Mac and the Pi act exactly the same.

**First time on a machine**

- Mac: install Docker Desktop and open it.
- Pi: `curl -fsSL https://get.docker.com | sh`

**Then just**

```
./docker.sh          # drops you into a shell with ROS ready
./docker.sh build    # builds and runs our code
```

That's it. Edit the code like normal, the container sees your changes.

**If something's weird**

- Mac and Pi can't see each other? In Docker Desktop, go to Settings → Resources → Network and turn on host networking.
- Want a fresh start? `docker compose down` and run `./docker.sh` again.
