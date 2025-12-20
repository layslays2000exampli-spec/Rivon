const { Client, GatewayIntentBits } = require("discord.js");
const { joinVoiceChannel, createAudioPlayer, createAudioResource, AudioPlayerStatus } = require("@discordjs/voice");
const ytdl = require("ytdl-core");
const ytSearch = require("yt-search");
const config = require("./config.json");

const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildVoiceStates,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent
  ]
});

let player = createAudioPlayer();
let queue = [];

client.once("ready", () => {
  console.log(`✅ Logged in as ${client.user.tag}`);
});

client.on("messageCreate", async (message) => {
  if (!message.guild || message.author.bot) return;

  const args = message.content.split(" ");
  const command = args.shift().toLowerCase();

  // ▶️ play
  if (command === "!play") {
    if (!message.member.voice.channel)
      return message.reply("❌ ادخل روم صوتي أول");

    const query = args.join(" ");
    if (!query) return message.reply("❌ اكتب اسم الأغنية"
