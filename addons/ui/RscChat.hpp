class RscText;
class RscDisplayChat {
    class controls {
        delete Line;
        delete Background;
        class CA_Background: RscText {
            colorBackground[] = {0.5, 0.5, 0.5, 0.33}; // Make the chat entry field slightly darker
        };
    };
};

class RscChatListDefault {
    colorBackground[] = {0, 0, 0, 0.5}; // Make the chat background darker
    colorMessageProtocol[] = {0.85, 0.85, 0.85, 1}; // And the chat text brighter
};
