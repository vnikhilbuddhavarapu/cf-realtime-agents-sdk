# Cloudflare Realtime Agent

A Cloudflare Worker that implements an AI-powered realtime agent using speech-to-text, AI processing, and text-to-speech capabilities.

## Setup

1. Create a new Worker project:

   ```bash
   npm create cloudflare@latest -- cf-rt-agent
   cd cf-rt-agent
   ```

2. Install the Realtime Agents SDK:

   ```bash
   npm i @cloudflare/realtime-agents
   ```

3. Configure your wrangler.jsonc with AI binding and Durable Objects:

   ```json
   {
   	"$schema": "./node_modules/wrangler/config-schema.json",
   	"ai": { "binding": "AI" },
   	"compatibility_flags": ["nodejs_compat"],
   	"migrations": [{ "new_sqlite_classes": ["MyAgent"], "tag": "v1" }],
   	"durable_objects": {
   		"bindings": [{ "class_name": "MyAgent", "name": "MY_AGENT" }]
   	}
   }
   ```

4. Set up required secrets:
   ```bash
   npx wrangler secret put ACCOUNT_ID
   npx wrangler secret put API_TOKEN
   npx wrangler secret put DEEPGRAM_API_KEY
   npx wrangler secret put ELEVENLABS_API_KEY
   # Optional
   npx wrangler secret put ELEVENLABS_VOICE_FEMALE
   npx wrangler secret put ELEVENLABS_VOICE_MALE
   ```

## Deployment

1. Login to Cloudflare:

   ```bash
   npx wrangler login
   ```

2. Deploy the Worker:
   ```bash
   npx wrangler deploy
   ```

## Usage

1. Create a meeting in the [Cloudflare Realtime Dashboard](https://dash.realtime.cloudflare.com/dashboard)
2. Get the meeting ID and auth token from the meeting join link
3. Initialize the agent:
   ```bash
   curl -X POST "https://your-worker.your-subdomain.workers.dev/init?meetingId=<MEETING_ID>" \
        -H "Authorization: Bearer <AUTH_TOKEN>"
   ```

## How It Works

The agent creates a pipeline that:

- Connects to RealtimeKit meetings
- Transcribes speech using Deepgram
- Generates responses using Cloudflare Workers AI (Llama 3.1)
- Converts responses to speech using ElevenLabs

The agent will automatically join meetings, respond to speech, and announce when participants join or leave.
