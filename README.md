# Rivonimport discord
from discord.ext import commands

intents = discord.Intents.default()
intents.message_content = True
intents.members = True

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user}')

# أمر البرودكاست: !bc رسالتك هنا
@bot.command()
@commands.has_permissions(administrator=True)
async def bc(ctx, *, message):
    for member in ctx.guild.members:
        if not member.bot:
            try:
                await member.send(message)
            except:
                continue
    await ctx.send("✅ تم إرسال البرودكاست لجميع الأعضاء.")

bot.run('ضع_التوكن_هنا')\
